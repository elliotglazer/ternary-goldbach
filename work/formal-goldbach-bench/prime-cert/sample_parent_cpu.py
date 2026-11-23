"""Return the launching Lean process's cumulative user+kernel CPU nanoseconds."""
import ctypes, os, sys

class FILETIME(ctypes.Structure):
    _fields_=[('low',ctypes.c_uint32),('high',ctypes.c_uint32)]
k=ctypes.windll.kernel32
k.OpenProcess.argtypes=[ctypes.c_uint32,ctypes.c_int,ctypes.c_uint32]
k.OpenProcess.restype=ctypes.c_void_p
k.GetProcessTimes.argtypes=[ctypes.c_void_p]+[ctypes.POINTER(FILETIME)]*4
k.CloseHandle.argtypes=[ctypes.c_void_p]
h=k.OpenProcess(0x1000,False,int(sys.argv[1]) if len(sys.argv)>1 else os.getppid())
if not h: raise ctypes.WinError()
try:
    creation,exit_time,kernel,user=FILETIME(),FILETIME(),FILETIME(),FILETIME()
    if not k.GetProcessTimes(h,ctypes.byref(creation),ctypes.byref(exit_time),ctypes.byref(kernel),ctypes.byref(user)):
        raise ctypes.WinError()
    print(((kernel.high<<32)+kernel.low+(user.high<<32)+user.low)*100)
finally:
    k.CloseHandle(h)
