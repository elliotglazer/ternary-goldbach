#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef uint64_t U;
typedef __uint128_t W;
#define MAX_NODES 100000
#define MAX_ROOTS 100000
#define MAX_BYTES 16000000
#define LIMIT 4000000000000000000ULL
typedef struct { U nodes, roots, pow_checks, squares, products, gcds, cache_hits, inverses; } Stats;
typedef struct { U n, inv, one, r2; } Mont;
typedef struct { const unsigned char *p,*end; int bad; } Reader;
typedef struct { U *p; size_t count; } Cache;
static const char *error;
static int fail(const char *s) { error=s; return 0; }
static U read_u(Reader *r,unsigned k) {
  U x=0;
  if ((size_t)(r->end-r->p)<k) {r->bad=1;return 0;}
  for(unsigned i=0;i<k;i++) x|=(U)*r->p++<<(8*i);
  return x;
}
static int contains(const U *v,size_t n,U x) {
  size_t a=0,b=n;
  while(a<b){size_t m=a+(b-a)/2;if(v[m]<x)a=m+1;else b=m;}
  return a<n&&v[a]==x;
}
static Mont mont(U n) {
  Mont c;c.n=n;U inv=1;
  for(unsigned i=0;i<6;i++)inv*=2-n*inv;
  c.inv=0-inv;c.one=UINT64_MAX%n+1;if(c.one==n)c.one=0;
  c.r2=c.one;
  for(unsigned i=0;i<64;i++){c.r2*=2;if(c.r2>=n)c.r2-=n;}
  return c;
}
static U mm(Mont c,U a,U b) {
  W t=(W)a*b;U m=(U)t*c.inv;
  U x=(U)((t+(W)m*c.n)>>64);
  return x>=c.n?x-c.n:x;
}
static U exponent(Mont c,const U *powers,U e,Stats *s) {
  U x=c.one;unsigned i=0;s->pow_checks++;
  while(e){if(e&1){x=mm(c,x,powers[i]);s->products++;}e>>=1;i++;}
  return x;
}
static U gcd(U a,U b){while(b){U r=a%b;a=b;b=r;}return a;}
static int validate(const unsigned char *data,size_t size,const Cache *cache,Cache *result,Stats *s) {
  error=NULL;
  if(size<16||size>MAX_BYTES||memcmp(data,"POCK000",7)||(data[7]!='1'&&data[7]!='2'))return fail("header");
  int inverse_mode=data[7]=='2';
  Reader r={data+8,data+size,0};U nn=read_u(&r,4),nr=read_u(&r,4);
  if(nn>MAX_NODES||nr>MAX_ROOTS)return fail("resource count");
  U *known=malloc((nn?nn:1)*sizeof(U));if(!known)return fail("allocation");
  #define BAD(msg) do{free(known);return fail(msg);}while(0)
  for(U i=0;i<nn;i++){
    U n=read_u(&r,8),a=read_u(&r,8),rem=read_u(&r,8),nf=read_u(&r,1);
    if(r.bad)BAD("truncated node");
    if(n<2||n>LIMIT||(i&&known[i-1]>=n)||nf>64)BAD("node bounds/order");
    U qs[64],vs[64],F=1,prev=0;
    for(U j=0;j<nf;j++){
      U q=read_u(&r,8),e=read_u(&r,1);qs[j]=q;
      vs[j]=inverse_mode?read_u(&r,8):0;
      if(r.bad)BAD("truncated factor");
      if(q<2||q>=n||q<=prev||e<1||e>62)BAD("factor bounds/order");
      if(inverse_mode&&(vs[j]==0||vs[j]>=n))BAD("inverse bounds");
      prev=q;
      int found=contains(known,i,q);
      if(!found&&cache&&contains(cache->p,cache->count,q)){found=1;s->cache_hits++;}
      if(!found)BAD("unproved factor");
      for(U k=0;k<e;k++){if(F>(n-1)/q)BAD("factor product overflow");F*=q;}
    }
    if(n==2){if(nf||a||rem!=1)BAD("base case");}
    else{
      if(!(n&1)||a<2||a>=n||rem<1||F<2||(n-1)%F||(n-1)/F!=rem||(W)F*F<=n)BAD("Pocklington arithmetic");
      Mont c=mont(n);U powers[64];powers[0]=mm(c,a,c.r2);s->products++;
      unsigned bits=64-__builtin_clzll(n-1);
      for(unsigned j=1;j<bits;j++){powers[j]=mm(c,powers[j-1],powers[j-1]);s->squares++;}
      if(exponent(c,powers,n-1,s)!=c.one)BAD("Fermat residue");
      for(U j=0;j<nf;j++){
        U x=exponent(c,powers,(n-1)/qs[j],s);s->products++;
        if(inverse_mode){
          U d=x>=c.one?x-c.one:x+n-c.one;s->inverses++;
          if(mm(c,d,vs[j])!=1)BAD("Pocklington inverse");
        }else{
          x=mm(c,x,1);s->gcds++;
          if(gcd(x?x-1:n-1,n)!=1)BAD("Pocklington gcd");
        }
      }
    }
    known[i]=n;s->nodes++;
  }
  for(U i=0;i<nr;i++){
    U n=read_u(&r,8);
    if(r.bad)BAD("truncated root");
    if(!contains(known,nn,n)&&!(cache&&contains(cache->p,cache->count,n)))BAD("unproved root");
    s->roots++;
  }
  if(r.bad||r.p!=r.end)BAD("trailing bytes");
  if(result){result->p=known;result->count=nn;}else free(known);
  return 1;
}
static unsigned char *load(const char *path,size_t *n) {
  FILE *f=fopen(path,"rb");if(!f)return NULL;
  if(fseek(f,0,SEEK_END)){fclose(f);return NULL;}long z=ftell(f);
  if(z<0||z>MAX_BYTES){fclose(f);return NULL;}rewind(f);
  unsigned char *p=malloc(z?z:1);if(!p){fclose(f);return NULL;}
  if(fread(p,1,z,f)!=(size_t)z){free(p);fclose(f);return NULL;}
  fclose(f);*n=z;return p;
}
static double cpu(void){struct timespec t;clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t);return t.tv_sec+t.tv_nsec*1e-9;}
int main(int argc,char **argv){
  if(argc<3||argc>4){fprintf(stderr,"usage: validate FILE REPS [CACHE]\n");return 2;}
  unsigned reps=(unsigned)strtoul(argv[2],NULL,10);if(!reps||reps>10000)return 2;
  Cache cache={0};double setup=0;Stats setup_stats={0};
  if(argc==4){size_t z;unsigned char *b=load(argv[3],&z);if(!b)return 2;
    double t=cpu();int ok=validate(b,z,NULL,&cache,&setup_stats);setup=cpu()-t;free(b);
    if(!ok){fprintf(stderr,"REJECT cache: %s\n",error);return 1;}}
  size_t z;unsigned char *b=load(argv[1],&z);if(!b){free(cache.p);return 2;}
  double t=cpu();Stats stats={0};
  for(unsigned i=0;i<reps;i++){Stats s={0};if(!validate(b,z,argc==4?&cache:NULL,NULL,&s)){
      fprintf(stderr,"REJECT: %s\n",error);free(b);free(cache.p);return 1;}stats=s;}
  double elapsed=cpu()-t;
  printf("{\"accepted\":true,\"reps\":%u,\"bytes\":%zu,\"cpu_seconds\":%.9f,\"cache_setup_cpu_seconds\":%.9f,\"cache_nodes\":%zu,\"nodes\":%llu,\"roots\":%llu,\"pow_checks\":%llu,\"squares\":%llu,\"products\":%llu,\"gcds\":%llu,\"cache_hits\":%llu,\"inverse_checks\":%llu}\n",
    reps,z,elapsed,setup,cache.count,(unsigned long long)stats.nodes,(unsigned long long)stats.roots,
    (unsigned long long)stats.pow_checks,(unsigned long long)stats.squares,(unsigned long long)stats.products,
    (unsigned long long)stats.gcds,(unsigned long long)stats.cache_hits,(unsigned long long)stats.inverses);
  free(b);free(cache.p);return 0;
}
