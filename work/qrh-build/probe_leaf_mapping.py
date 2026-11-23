"""Unexecuted optional mapping observer for original-imports ONLY.

Coordinator launch: python probe_leaf_mapping.py --run
Exact pinned variant runner/monitor; unchanged 4-GiB sampled-private / 600s
limits and options. No build, dependency edit, cache reuse or publication.
Mapping scans: first sample, first >=3-GiB sample below the 4-GiB stop, final.
Each scan is capped at 0.10s / 10,000 regions / 64 file-name queries; a single
Windows call cannot be interrupted by this soft cap. Partial totals are NEVER
reported as complete. The child continues during scans, so results are not
atomic and observation can increase between-sample overshoot. No clean speed
comparison is valid. At >=4GiB do not delay termination for a mapping scan.
The final process may have exited: failed address-space queries are recorded.
"""
from pathlib import Path
from datetime import datetime, timezone
import argparse
import ctypes as ct
from ctypes import wintypes as wt
import hashlib
import json
import os
import sys
import time
import traceback
import types

HERE = Path(__file__).resolve().parent
WRAPPER = HERE/'probe_leaf_imports.py'
WRAPPER_PIN = '6692bdc8ab6de8c4d04868b1f8c79edd5fede08b8008d46624abe737672d1404'
SCAN_SECONDS = 0.10
MAX_REGIONS = 10000
MAX_NAMES = 64
EARLY_THRESHOLD = 3 * 1024**3


class MemoryStatus(ct.Structure):
    _fields_ = [('length', wt.DWORD), ('memory_load_percent', wt.DWORD)] + [
        (s, ct.c_ulonglong) for s in ('total_phys', 'avail_phys', 'total_pagefile',
                                    'avail_pagefile', 'total_virtual', 'avail_virtual', 'avail_extended_virtual')]


class MemoryBasicInformation(ct.Structure):
    # Windows x64 MEMORY_BASIC_INFORMATION, including WORD PartitionId padding.
    _fields_ = [('base_address', ct.c_void_p), ('allocation_base', ct.c_void_p),
                ('allocation_protect', wt.DWORD), ('partition_id', wt.WORD),
                ('region_size', ct.c_size_t), ('state', wt.DWORD),
                ('protect', wt.DWORD), ('type', wt.DWORD)]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def utc():
    return datetime.now(timezone.utc).isoformat()


class Observer:
    def __init__(self):
        if ct.sizeof(ct.c_void_p) != 8 or ct.sizeof(MemoryBasicInformation) != 48:
            raise RuntimeError('Only Windows x64 structure layout is supported.')
        self.k = ct.WinDLL('kernel32', use_last_error=True)
        self.p = ct.WinDLL('psapi', use_last_error=True)
        self.k.GlobalMemoryStatusEx.argtypes = [ct.POINTER(MemoryStatus)]
        self.k.GlobalMemoryStatusEx.restype = wt.BOOL
        self.k.VirtualQueryEx.argtypes = [wt.HANDLE, ct.c_void_p,
                                          ct.POINTER(MemoryBasicInformation), ct.c_size_t]
        self.k.VirtualQueryEx.restype = ct.c_size_t
        self.p.GetMappedFileNameW.argtypes = [wt.HANDLE, ct.c_void_p, wt.LPWSTR, wt.DWORD]
        self.p.GetMappedFileNameW.restype = wt.DWORD
        self.events = []
        self.attempt = None
        self.result = None
        self.samples = 0
        self.threshold_done = False
        self.final_done = False

    def global_memory(self):
        data = MemoryStatus()
        data.length = ct.sizeof(data)
        if not self.k.GlobalMemoryStatusEx(ct.byref(data)):
            return {'error': 'GlobalMemoryStatusEx', 'winerror': ct.get_last_error()}
        return {name: int(getattr(data, name)) for name, _ in data._fields_}

    def mapping_scan(self, process):
        began = time.monotonic()
        # Upper end of standard Windows x64 application address range; a failed
        # query does NOT count as completion. Explicit range coverage is required.
        limit = 0x0000800000000000
        address = count = names = 0
        totals = {}
        files = {}
        file_errors = []
        type_names = {0x20000: 'MEM_PRIVATE', 0x40000: 'MEM_MAPPED', 0x1000000: 'MEM_IMAGE'}
        status = 'range_complete'
        error = None
        while address < limit:
            if time.monotonic()-began >= SCAN_SECONDS:
                status = 'time_cap_partial'
                break
            if count >= MAX_REGIONS:
                status = 'region_cap_partial'
                break
            data = MemoryBasicInformation()
            got = self.k.VirtualQueryEx(int(process._handle), ct.c_void_p(address),
                                       ct.byref(data), ct.sizeof(data))
            if got != ct.sizeof(data):
                status = 'query_failed_partial'
                error = dict(address=address, returned_bytes=int(got), winerror=ct.get_last_error())
                break
            base, size = int(data.base_address or 0), int(data.region_size)
            end = base+size
            if size <= 0 or end <= address:
                status = 'invalid_region_partial'
                error = dict(address=address, base=base, size=size)
                break
            count += 1
            key = f"state=0x{data.state:x};type={type_names.get(data.type, hex(data.type))};protect=0x{data.protect:x};allocation_protect=0x{data.allocation_protect:x}"
            total = totals.setdefault(key, {'regions': 0, 'virtual_bytes': 0})
            total['regions'] += 1
            total['virtual_bytes'] += size
            if data.state == 0x1000 and data.type in (0x40000, 0x1000000) and names < MAX_NAMES:
                names += 1
                buf = ct.create_unicode_buffer(32768)
                n = self.p.GetMappedFileNameW(int(process._handle), ct.c_void_p(base), buf, len(buf))
                if n == 0 or n >= len(buf):
                    file_errors.append(dict(address=base, winerror=ct.get_last_error(), returned_chars=int(n)))
                else:
                    name = buf.value
                    row = files.setdefault(name, {'regions_queried': 0, 'virtual_bytes_in_queried_regions': 0,
                                                  'compacted_artifact_suffix': name.lower().endswith(('.olean', '.olean.private', '.olean.server', '.ir', '.ir.sig'))})
                    row['regions_queried'] += 1
                    row['virtual_bytes_in_queried_regions'] += size
            address = end
        return dict(status=status, complete=status == 'range_complete', scan_wall_seconds=time.monotonic()-began,
                    covered_up_to=address, intended_upper_bound=limit, regions=count,
                    totals_by_state_type_protection=totals, mapped_files=files,
                    mapped_name_queries=names, mapped_name_query_cap=MAX_NAMES,
                    mapped_name_errors=file_errors, error=error,
                    semantics='Non-atomic virtual region sizes, NOT resident bytes or exact per-region private commitment.')

    def event(self, name, process=None, sample=None, scan=False):
        event = dict(event=name, utc=utc(), global_memory=self.global_memory())
        if sample is not None:
            event['process_sample'] = sample
        if scan and process is not None:
            try:
                event['mapping_scan'] = self.mapping_scan(process)
            except Exception as error:
                event['mapping_scan_error'] = repr(error)
        self.events.append(event)
        if self.attempt is not None:
            # Each event has its own exclusive file; no overwrites or shared append.
            with (self.attempt/f'mapping_event_{len(self.events):04d}.json').open('xb') as stream:
                stream.write((json.dumps(event, sort_keys=True)+'\n').encode())
        return event


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', action='store_true')
    args = parser.parse_args()
    if not args.run:
        parser.error('No launch without --run.')
    if os.name != 'nt':
        parser.error('Windows only.')
    payload = WRAPPER.read_bytes()
    if sha(payload) != WRAPPER_PIN:
        raise RuntimeError('Variant wrapper changed; re-review required.')
    wrapper = types.ModuleType('_pinned_variant_wrapper')
    wrapper.__file__ = str(WRAPPER)
    exec(compile(payload, str(WRAPPER), 'exec'), wrapper.__dict__)
    observer = Observer()
    original_loader = wrapper.load_monitor

    def observed_loader():
        module = original_loader()
        base_monitor = module.WindowsMonitor
        original_json = module.exclusive_json

        def request_hook(path, value):
            if path.name == 'request.json':
                observer.attempt = path.parent
                observer.result = value
                value['mapping_observer'] = dict(driver=str(Path(__file__).resolve()),
                    sha256=sha(Path(__file__).read_bytes()), wrapper_pin=WRAPPER_PIN,
                    scan_seconds_cap=SCAN_SECONDS, region_cap=MAX_REGIONS, name_query_cap=MAX_NAMES,
                    early_threshold_bytes=EARLY_THRESHOLD, speed_comparison_valid=False,
                    interpretation='Partial address-space observations; no COW or memory-demand attribution assumed.')
            original_json(path, value)

        class ObservedMonitor(base_monitor):
            def sample(self, process):
                sample = super().sample(process)
                stopped = sample['private_bytes'] >= module.PRIVATE_BYTES
                scan = not stopped and (observer.samples == 0 or (
                    not observer.threshold_done and sample['private_bytes'] >= EARLY_THRESHOLD))
                if scan and sample['private_bytes'] >= EARLY_THRESHOLD:
                    observer.threshold_done = True
                observer.event('sample_stop_threshold_no_scan' if stopped else 'sample', process, sample, scan)
                observer.samples += 1
                return sample

            def cpu(self, process):
                values = super().cpu(process)
                # Base sample calls cpu too: only take final scan once process has exited.
                if process.poll() is not None and not observer.final_done:
                    observer.final_done = True
                    observer.event('final_process_exited_best_effort', process, scan=True)
                return values

        module.WindowsMonitor = ObservedMonitor
        module.exclusive_json = request_hook
        return module

    wrapper.load_monitor = observed_loader
    wrapper.QUARANTINE = HERE/'leaf-mapping-quarantine'
    old_args = sys.argv
    try:
        sys.argv = [str(WRAPPER), '--variant', 'original-imports', '--run']
        return wrapper.main()
    finally:
        sys.argv = old_args
        if observer.attempt is not None:
            observer.event('observer_post_stop')
            receipt = observer.attempt/'diagnostic.json'
            summary = dict(kind='optional_mapping_observer_only', observer_sha256=sha(Path(__file__).read_bytes()),
                           wrapper_sha256=WRAPPER_PIN, events=len(observer.events),
                           diagnostic_sha256=sha(receipt.read_bytes()) if receipt.exists() else None,
                           provider_validated=False, reusable_accepted_artifact=False,
                           no_memory_guard_change=True, performance_comparison_valid=False)
            with (observer.attempt/'mapping_summary.json').open('xb') as stream:
                stream.write((json.dumps(summary, indent=2)+'\n').encode())


if __name__ == '__main__':
    raise SystemExit(main())
