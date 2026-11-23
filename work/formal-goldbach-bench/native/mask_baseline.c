#include <stdint.h>
/* Windows x64 ABI declarations; bundled Clang lacks system C headers. */
typedef unsigned long long size_t;
int printf(const char *, ...);
void *malloc(size_t);
void free(void *);
void *memset(void *, int, size_t);
typedef struct { unsigned long dwLowDateTime, dwHighDateTime; } FILETIME;
typedef union { struct { unsigned long LowPart, HighPart; }; unsigned long long QuadPart; } ULARGE_INTEGER;
typedef union { struct { unsigned long LowPart; long HighPart; }; long long QuadPart; } LARGE_INTEGER;
__declspec(dllimport) void *GetCurrentProcess(void);
__declspec(dllimport) int GetProcessTimes(void *, FILETIME *,FILETIME *,FILETIME *,FILETIME *);
__declspec(dllimport) int QueryPerformanceCounter(LARGE_INTEGER *);
__declspec(dllimport) int QueryPerformanceFrequency(LARGE_INTEGER *);

/* Native operation baseline only: random masks, no primality proof. */
static uint64_t state = 20261110;
static uint64_t random64(void) {
  state ^= state << 13; state ^= state >> 7; state ^= state << 17;
  return state;
}
static double cpu_seconds(void) {
  FILETIME c,e,k,u;
  GetProcessTimes(GetCurrentProcess(), &c,&e,&k,&u);
  ULARGE_INTEGER a,b;
  a.LowPart=k.dwLowDateTime; a.HighPart=k.dwHighDateTime;
  b.LowPart=u.dwLowDateTime; b.HighPart=u.dwHighDateTime;
  return (a.QuadPart+b.QuadPart)*1e-7;
}
static double wall_seconds(void) {
  LARGE_INTEGER t,f; QueryPerformanceCounter(&t); QueryPerformanceFrequency(&f);
  return (double)t.QuadPart/(double)f.QuadPart;
}
static void apply(uint64_t * restrict dst, const uint64_t * restrict src,
                  size_t words, unsigned shift) {
  for(size_t j=0;j<words;j++)
    dst[j] |= (src[j]>>shift) | (src[j+1]<<(64-shift));
}
int main(void) {
  const size_t sizes[] = {1,16,256,1024,16384};
  const unsigned masks=128;
  const size_t window=8192;
  uint64_t *src=malloc((window+16384+1)*sizeof(uint64_t));
  uint64_t *dst=malloc(16384*sizeof(uint64_t));
  if(!src || !dst) return 2;
  for(size_t j=0;j<window+16384+1;j++) src[j]=random64()&random64()&random64();
  unsigned offsets[128], shifts[128];
  for(unsigned j=0;j<masks;j++) {offsets[j]=random64()%window; shifts[j]=1+random64()%63;}
  /* Independently compare each output bit for one nontrivial shift. */
  memset(dst,0,16*sizeof(uint64_t)); apply(dst,src+17,16,23);
  for(size_t bit=0;bit<1024;bit++) {
    size_t origin=bit+23;
    if(((dst[bit/64]>>(bit%64))&1) != ((src[17+origin/64]>>(origin%64))&1)) return 3;
  }
  volatile uint64_t checksum=0;
  printf("{\"kind\":\"native_random_mask_baseline\",\"masks\":128,\"selfcheck\":true,\"cases\":[\n");
  for(unsigned s=0;s<sizeof(sizes)/sizeof(sizes[0]);s++) {
    size_t words=sizes[s];
    size_t repetitions=2000000000ULL/(words*masks);
    double c0=cpu_seconds(),w0=wall_seconds();
    for(size_t r=0;r<repetitions;r++) {
      memset(dst,0,words*sizeof(uint64_t));
      for(unsigned a=0;a<masks;a++) apply(dst,src+offsets[a],words,shifts[a]);
      checksum += dst[r%words];
    }
    double wall=wall_seconds()-w0,cpu=cpu_seconds()-c0;
    printf("%s{\"bits\":%llu,\"repetitions\":%llu,\"word_mask_ops\":%llu,\"cpu_seconds\":%.6f,\"wall_seconds\":%.6f}",s?",\n":"",(unsigned long long)words*64,(unsigned long long)repetitions,(unsigned long long)repetitions*words*masks,cpu,wall);
  }
  printf("\n],\"checksum\":\"%016llx\"}\n",(unsigned long long)checksum);
  free(src);free(dst);return 0;
}
