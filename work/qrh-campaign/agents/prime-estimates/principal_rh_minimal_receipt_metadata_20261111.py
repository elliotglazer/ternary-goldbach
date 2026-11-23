"""Integer metadata only. No ordinate data or analytic functions are evaluated."""
import json
from pathlib import Path


def main():
    upper_height = 100000001
    hypothetical_samples = 250000001
    rows = []
    for fractional_bits, low_bits in [(8, 6), (10, 8), (16, 14)]:
        key_max = upper_height << fractional_bits
        high_positions = (key_max >> low_bits) + hypothetical_samples + 1
        bits = hypothetical_samples * low_bits + high_positions
        fixed_bits = key_max.bit_length()
        rows.append({
            "coarse_fractional_bits": fractional_bits,
            "low_bits_per_key": low_bits,
            "maximum_key": key_max,
            "high_bitvector_length_upper": high_positions,
            "base_payload_bits_upper": bits,
            "base_payload_bytes_upper": (bits + 7) // 8,
            "fixed_coordinate_bits": fixed_bits,
            "byte_aligned_fixed_payload_bytes": hypothetical_samples * ((fixed_bits + 7) // 8),
        })
    # Symbolic codec construction checked on bounded synthetic integer keys only.
    codec_cases = 0
    for keys in [[], [0], [0, 0, 1, 1, 9, 25], [3, 17, 17, 65536]]:
        for ell in [0, 1, 4, 8]:
            lows = [x % (1 << ell) for x in keys]
            positions = [(x >> ell) + i for i, x in enumerate(keys)]
            assert all(a < b for a, b in zip(positions, positions[1:]))
            recovered = [((pos - i) << ell) + lo for i, (pos, lo) in enumerate(zip(positions, lows))]
            assert recovered == keys
            codec_cases += 1
    assert 6 * 4096**2 > upper_height
    result = {
        "scope": "Hypothetical payload and schedule sensitivity, not an actual zero count or certificate",
        "H": 100000000,
        "conditional_top_upper": upper_height,
        "hypothetical_sample_count": hypothetical_samples,
        "coordinate_rows": rows,
        "historical_13_byte_record_proxy_bytes": 13 * hypothetical_samples,
        "one_eighth_grid_intervals_to_upper_height": 8 * upper_height,
        "independent_K0_main_terms_per_high_sample_upper": 4095,
        "independent_K0_main_terms_total_upper": 4095 * hypothetical_samples,
        "integer_witness_six_times_4096_squared": 6 * 4096**2,
        "synthetic_codec_cases": codec_cases,
        "excluded": ["fine-grid exceptions", "headers", "analytic enclosures", "proof bytes", "runtime", "actual zero counts"],
    }
    out = Path(__file__).with_suffix(".json")
    out.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(out), "rows": len(rows), "synthetic_codec_cases": codec_cases}))


if __name__ == "__main__":
    main()
