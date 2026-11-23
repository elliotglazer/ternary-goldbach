#include <stdint.h>
typedef unsigned long long size_t;
int printf(const char*,...);
void *malloc(size_t);
void free(void*);
void *fopen(const char*,const char*);
size_t fread(void*,size_t,size_t,void*);
int fclose(void*);
typedef struct { unsigned long lo,hi; } FILETIME;
typedef union { struct { unsigned long lo; long hi; }; long long value; } LARGE_INTEGER;
__declspec(dllimport) void *GetCurrentProcess(void);
__declspec(dllimport) int GetProcessTimes(void*,FILETIME*,FILETIME*,FILETIME*,FILETIME*);
__declspec(dllimport) int QueryPerformanceCounter(LARGE_INTEGER*);
__declspec(dllimport) int QueryPerformanceFrequency(LARGE_INTEGER*);
static double cpu(void){FILETIME a,b,k,u;GetProcessTimes(GetCurrentProcess(),&a,&b,&k,&u);return (((uint64_t)k.hi<<32)+k.lo+((uint64_t)u.hi<<32)+u.lo)*1e-7;}
static double wall(void){LARGE_INTEGER a,b;QueryPerformanceCounter(&a);QueryPerformanceFrequency(&b);return (double)a.value/(double)b.value;}
static unsigned greedy(const uint64_t *m,unsigned n){
  uint64_t rem=~(uint64_t)0; unsigned chosen=0;
  while(rem){unsigned score=0,best=0;
    for(unsigned k=0;k<n;k++){unsigned x=__builtin_popcountll(rem&m[k]);if(x>score){score=x;best=k;}}
    if(!score)return 999;
    rem &= ~m[best];chosen++;
  }return chosen;
}
static unsigned sequential(const uint64_t*m,unsigned n){uint64_t rem=~(uint64_t)0;for(unsigned k=0;k<n;k++){rem&=~m[k];if(!rem)return k+1;}return 999;}
int main(int argc,char**argv){
  if(argc!=2)return 2;
  void*f=fopen(argv[1],"rb");if(!f)return 3;
  uint64_t h[2];if(fread(h,8,2,f)!=2)return 4;
  uint64_t *m=malloc(h[0]*h[1]*8);if(!m)return 5;
  if(fread(m,8,h[0]*h[1],f)!=h[0]*h[1])return 6;fclose(f);
  volatile uint64_t checksum=0;
  printf("{\"rows\":%llu,\"columns\":%llu,\"cases\":[",h[0],h[1]);
  for(unsigned mode=0;mode<4;mode++){
    unsigned n=(mode%2)?1024:512;unsigned isseq=mode>=2;
    unsigned reps=isseq?200:20;
    uint64_t total=0;unsigned max=0,fail=0;
    double c=cpu(),w=wall();
    for(unsigned r=0;r<reps;r++)for(size_t j=0;j<h[0];j++){
      unsigned v=isseq?sequential(m+j*h[1],n):greedy(m+j*h[1],n);
      checksum+=v;if(!r){total+=v;if(v>max)max=v;fail+=(v==999);}
    }
    c=cpu()-c;w=wall()-w;
    printf("%s{\"method\":\"%s\",\"pool\":%u,\"repetitions\":%u,\"cpu_seconds\":%.9f,\"wall_seconds\":%.9f,\"mean_count\":%.12f,\"max_count\":%u,\"failures\":%u}",mode?",":"",isseq?"sequential":"greedy",n,reps,c,w,(double)total/h[0],max,fail);
  }
  printf("],\"checksum\":%llu}\n",checksum);free(m);return 0;
}
