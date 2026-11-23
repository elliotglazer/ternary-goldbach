#include <stdint.h>
typedef unsigned long long size_t;
int printf(const char*,...);void*malloc(size_t);void free(void*);
void*memset(void*,int,size_t);void*memcpy(void*,const void*,size_t);
void*fopen(const char*,const char*);size_t fread(void*,size_t,size_t,void*);int fclose(void*);
typedef struct{unsigned long lo,hi;} FILETIME;
typedef union{struct{unsigned long lo;long hi;};long long value;} LI;
__declspec(dllimport) void*GetCurrentProcess(void);
__declspec(dllimport) int GetProcessTimes(void*,FILETIME*,FILETIME*,FILETIME*,FILETIME*);
__declspec(dllimport) int QueryPerformanceCounter(LI*);
__declspec(dllimport) int QueryPerformanceFrequency(LI*);
static double wall(void){LI a,b;QueryPerformanceCounter(&a);QueryPerformanceFrequency(&b);return(double)a.value/b.value;}
static double cpu(void){FILETIME a,b,k,u;GetProcessTimes(GetCurrentProcess(),&a,&b,&k,&u);return(((uint64_t)k.hi<<32)+k.lo+((uint64_t)u.hi<<32)+u.lo)*1e-7;}
typedef struct{uint64_t q,s;} Anchor;
typedef struct{uint64_t width,bits,na,sw,target,first,reference,id;Anchor*a;uint64_t*src;} Case;
typedef struct{int accepted;unsigned prefix;uint64_t updates;int invalid;} Answer;
typedef struct{uint64_t*dst;uint32_t*active;size_t capacity;} Workspace;
#define MODES 10
static const unsigned switch_at[MODES]={0,0,32,64,96,128,192,256};
static int workspace(Workspace*w,size_t n){if(w->capacity>=n)return 1;free(w->dst);free(w->active);w->dst=malloc(n*8);w->active=malloc(n*4);w->capacity=n;return w->dst&&w->active;}
static void release(Case*c){free(c->a);free(c->src);}
static int read_case(void*f,Case*c){
  uint64_t h[8];if(fread(h,8,8,f)!=8)return 0;
  if(!h[0]||h[0]>(1ULL<<28)||h[1]<h[0]||h[1]>(1ULL<<29)||!h[2]||h[2]>2048||h[3]!=(h[1]+63)/64)return 0;
  c->width=h[0];c->bits=h[1];c->na=h[2];c->sw=h[3];c->target=h[4];c->first=h[5];c->reference=h[6];c->id=h[7];
  c->a=malloc(c->na*16);c->src=malloc((c->sw+1)*8);if(!c->a||!c->src)return 0;
  if(fread(c->a,16,c->na,f)!=c->na||fread(c->src,8,c->sw,f)!=c->sw){release(c);return 0;}
  c->src[c->sw]=0;return 1;
}
static int header(void*f,uint64_t*n){char m[8];if(fread(m,1,8,f)!=8)return 0;const char*x="BULKCOV1";for(int i=0;i<8;i++)if(m[i]!=x[i])return 0;return fread(n,8,1,f)==1&&*n&&*n<=1024;}
static int valid(const Case*c){
  if(!c->width||c->bits<c->width||c->sw!=(c->bits+63)/64||!c->na||c->na>2048)return 0;
  if(c->target&1||!(c->first&1))return 0;
  for(size_t k=0;k<c->na;k++){
    uint64_t q=c->a[k].q,s=c->a[k].s;
    if(q<3||!(q&1)||q>c->target||s>c->bits-c->width)return 0;
    uint64_t difference=c->target-q;
    if(difference<c->first||difference-c->first!=2*s)return 0;
  }return 1;
}
static inline uint64_t slice(const uint64_t*s,size_t j,unsigned r){return(s[j]>>r)|(r?(s[j+1]<<(64-r)):0);}
static Answer check(const Case*c,unsigned mode,Workspace*w){
  Answer a={0,0,0,0};if(!valid(c)){a.invalid=1;return a;}
  if(mode>=8){
    uint64_t tile=mode==8?(1ULL<<16):(1ULL<<18);a.accepted=1;
    for(uint64_t off=0;off<c->width;off+=tile){Case z=*c;z.width=c->width-off<tile?c->width-off:tile;
      z.bits-=off;z.sw=(z.bits+63)/64;z.src+=off/64;z.first+=2*off;z.target+=2*off;
      Answer part=check(&z,4,w);a.updates+=part.updates;
      if(!part.accepted){a.accepted=0;a.invalid=part.invalid;return a;}
      if(part.prefix>a.prefix)a.prefix=part.prefix;
    }return a;
  }
  size_t n=(c->width+63)/64;if(!workspace(w,n)){a.invalid=1;return a;}
  memset(w->dst,0,n*8);unsigned tail=c->width&63;
  uint64_t last=tail?((1ULL<<tail)-1):~0ULL;size_t active=n;int sparse=(mode==1);
  if(sparse)for(size_t j=0;j<n;j++)w->active[j]=(uint32_t)j;
  for(size_t k=0;k<c->na;k++){
    size_t q=c->a[k].s>>6;unsigned r=c->a[k].s&63;const uint64_t*s=c->src+q;
    if(mode>=2&&k==switch_at[mode]){active=0;for(size_t j=0;j<n;j++)if((w->dst[j]&(j==n-1?last:~0ULL))!=(j==n-1?last:~0ULL))w->active[active++]=(uint32_t)j;sparse=1;}
    if(sparse){size_t remaining=0;a.updates+=active;
      for(size_t z=0;z<active;z++){size_t j=w->active[z];uint64_t v=w->dst[j]|slice(s,j,r);w->dst[j]=v;uint64_t wanted=(j==n-1?last:~0ULL);if((v&wanted)!=wanted)w->active[remaining++]=(uint32_t)j;}
      active=remaining;if(!active){a.accepted=1;a.prefix=(unsigned)k+1;return a;}
    }else{uint64_t missing=0;a.updates+=n;
      for(size_t j=0;j+1<n;j++){uint64_t v=w->dst[j]|slice(s,j,r);w->dst[j]=v;missing|=~v;}
      uint64_t v=w->dst[n-1]|slice(s,n-1,r);w->dst[n-1]=v;missing|=(~v)&last;
      if(!missing){a.accepted=1;a.prefix=(unsigned)k+1;return a;}
    }
  }return a;
}
static Case*load(const char*path,uint64_t*n){void*f=fopen(path,"rb");if(!f||!header(f,n))return 0;Case*c=malloc(*n*sizeof(Case));if(!c)return 0;for(size_t i=0;i<*n;i++)if(!read_case(f,c+i))return 0;fclose(f);return c;}
static uint64_t stream(const char*path,unsigned mode,Workspace*w){void*f=fopen(path,"rb");uint64_t n,sum=0;if(!f||!header(f,&n))return 0;for(size_t i=0;i<n;i++){Case c;if(!read_case(f,&c))return 0;Answer a=check(&c,mode,w);release(&c);if(!a.accepted)return 0;sum+=a.prefix;}fclose(f);return sum;}
int main(int argc,char**argv){
  if(argc!=2)return 2;uint64_t nc;double start=wall();Case*c=load(argv[1],&nc);double loadtime=wall()-start;if(!c)return 3;
  Workspace w={0,0,0};unsigned positives=0,negatives=0;uint64_t totalbits=0;
  for(size_t i=0;i<nc;i++){totalbits+=c[i].width;for(unsigned mode=0;mode<MODES;mode++){Answer a=check(c+i,mode,&w);if(!a.accepted||a.prefix!=c[i].reference)return 4;positives++;}}
  for(size_t i=0;i<nc;i++){if(i&&c[i].width==c[i-1].width)continue;Case negative=c[i];if(negative.width>(1ULL<<20))negative.width=1ULL<<20;Case*b=&negative;uint64_t*copy=malloc((b->sw+1)*8);memcpy(copy,b->src,(b->sw+1)*8);
    memset(b->src,0,(b->sw+1)*8);for(unsigned mode=0;mode<MODES;mode++){if(check(b,mode,&w).accepted)return 5;negatives++;}memcpy(b->src,copy,(b->sw+1)*8);
    size_t target=b->width/2;for(size_t a=0;a<b->na;a++){size_t bit=b->a[a].s+target;b->src[bit>>6]&=~(1ULL<<(bit&63));}
    for(unsigned mode=0;mode<MODES;mode++){if(check(b,mode,&w).accepted)return 6;negatives++;}memcpy(b->src,copy,(b->sw+1)*8);
    uint64_t save=b->a[0].s;b->a[0].s=b->bits-b->width+1;if(!check(b,0,&w).invalid)return 7;negatives++;b->a[0].s=save;
    save=b->a[0].q;b->a[0].q+=2;if(!check(b,0,&w).invalid)return 8;negatives++;b->a[0].q=save;free(copy);
  }
  volatile uint64_t checksum=0;printf("{\"cases\":%llu,\"initial_load_seconds\":%.9f,\"positive_checks\":%u,\"negative_checks\":%u,\"prime_certificates_checked\":false,\"loaded\":[",nc,loadtime,positives,negatives);
  unsigned emitted=0;for(unsigned mode=0;mode<MODES;mode++)for(unsigned wi=0;wi<7;wi++){
    uint64_t width=1ULL<<(16+2*wi),bits=0,updates=0,prefix=0;unsigned count=0;
    double t=wall();for(size_t i=0;i<nc;i++)if(c[i].width==width){Answer a=check(c+i,mode,&w);checksum+=a.prefix;bits+=width;updates+=a.updates;prefix+=a.prefix;count++;}
    if(!count)continue;double one=wall()-t;unsigned reps=(unsigned)(.12/(one>1e-6?one:1e-6));if(reps<1)reps=1;if(reps>100)reps=100;
    for(unsigned trial=0;trial<3;trial++){double ct=cpu(),wt=wall();for(unsigned r=0;r<reps;r++)for(size_t i=0;i<nc;i++)if(c[i].width==width){Answer a=check(c+i,mode,&w);if(!a.accepted)return 9;checksum+=a.prefix;}
      ct=cpu()-ct;wt=wall()-wt;printf("%s{\"mode\":%u,\"width\":%llu,\"trial\":%u,\"cases\":%u,\"reps\":%u,\"bits_per_sweep\":%llu,\"updates_per_sweep\":%llu,\"prefix_sum\":%llu,\"wall_seconds\":%.9f,\"cpu_seconds\":%.9f}",emitted++?",":"",mode,width,trial,count,reps,bits,updates,prefix,wt,ct);}
  }
  printf("],\"stream_parse\":[");emitted=0;for(unsigned mode=0;mode<MODES;mode++)for(unsigned trial=0;trial<3;trial++){
    unsigned reps=3;double ct=cpu(),wt=wall();for(unsigned r=0;r<reps;r++){uint64_t x=stream(argv[1],mode,&w);if(!x)return 10;checksum+=x;}ct=cpu()-ct;wt=wall()-wt;
    printf("%s{\"mode\":%u,\"trial\":%u,\"reps\":%u,\"bits_per_sweep\":%llu,\"wall_seconds\":%.9f,\"cpu_seconds\":%.9f}",emitted++?",":"",mode,trial,reps,totalbits,wt,ct);
  }
  printf("],\"checksum\":%llu}\n",checksum);for(size_t i=0;i<nc;i++)release(c+i);free(c);free(w.dst);free(w.active);return 0;
}
