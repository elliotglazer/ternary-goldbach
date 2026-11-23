#define main unused_cached_main
#include "native_greedy.c"
#undef main
typedef uint64_t v8u __attribute__((vector_size(64)));
typedef struct{unsigned score,index;} Choice;
static Choice choose_simd(const uint64_t*m,unsigned n,uint64_t rem){
  v8u rv={rem,rem,rem,rem,rem,rem,rem,rem};
  v8u best={0,0,0,0,0,0,0,0};
  v8u index={~0ULL,~0ULL,~0ULL,~0ULL,~0ULL,~0ULL,~0ULL,~0ULL};
  v8u pos={0,1,2,3,4,5,6,7},step={8,8,8,8,8,8,8,8};
  for(unsigned k=0;k<n;k+=8){
    v8u masks;__builtin_memcpy(&masks,m+k,64);
    v8u scores=__builtin_elementwise_popcount(masks&rv);
    v8u gt=(v8u)(scores>best);
    best=(gt&scores)|(~gt&best);
    index=(gt&pos)|(~gt&index);
    pos+=step;
  }
  Choice out={0,~0U};
  for(unsigned lane=0;lane<8;lane++){
    if(best[lane]>out.score || (best[lane]==out.score && index[lane]<out.index)){
      out.score=(unsigned)best[lane];out.index=(unsigned)index[lane];
    }
  }
  return out;
}
static uint64_t slice(const uint64_t*s,uint64_t off){unsigned b=off&63;size_t i=off>>6;return(s[i]>>b)|(b?(s[i+1]<<(64-b)):0);}
typedef struct{unsigned count,fallback,fallback_masks,attempted;} Result;
static Result run(const uint64_t*s,const uint64_t*sh,size_t j,unsigned small){
  Result out={0,0,0,0};uint64_t rem=~(uint64_t)0,m[512];
  if(!small){
    for(unsigned k=0;k<512;k++){uint64_t v=slice(s,sh[k]+64*j),next=rem&~v;out.attempted++;
      out.count+=(next!=rem);rem=next;if(!rem)return out;}
    out.count=999;return out;
  }
  for(unsigned k=0;k<small;k++)m[k]=slice(s,sh[k]+64*j);
  unsigned active=small;
  while(rem){Choice c=choose_simd(m,active,rem);
    if(!c.score){if(active==512){out.count=999;return out;}
      for(unsigned k=active;k<512;k++)m[k]=slice(s,sh[k]+64*j);
      active=512;out.fallback=1;continue;}
    rem&=~m[c.index];out.count++;out.fallback_masks+=out.fallback;
  }return out;
}
int main(int argc,char**argv){
  if(argc!=2)return 2;void*f=fopen(argv[1],"rb");if(!f)return 3;uint64_t h[4];if(fread(h,8,4,f)!=4)return 4;
  size_t stride=h[2]+h[3];uint64_t*d=malloc(h[0]*stride*8);if(!d)return 5;
  if(fread(d,8,h[0]*stride,f)!=h[0]*stride)return 6;fclose(f);
  /* Verify exact first-index choices against scalar search at every transition. */
  for(size_t k=0;k<h[0];k++){
    if(k%5==0)continue;const uint64_t*sh=d+k*stride,*s=sh+h[2];
    for(size_t j=0;j<h[1];j++){
      uint64_t masks[512];for(unsigned a=0;a<512;a++)masks[a]=slice(s,sh[a]+64*j);
      for(unsigned active=64;active<=512;active*=2){uint64_t rem=~(uint64_t)0;
        while(rem){Choice v=choose_simd(masks,active,rem);unsigned score=0,index=~0U;
          for(unsigned a=0;a<active;a++){unsigned b=__builtin_popcountll(rem&masks[a]);if(b>score){score=b;index=a;}}
          if(v.score!=score || (score && v.index!=index))return 11;
          if(!score)break;rem&=~masks[index];
        }
      }
    }
  }
  volatile uint64_t checksum=0;unsigned pools[5]={64,128,256,512,0};
  printf("{\"variant\":\"simd8_popcount\",\"exact_choice_selfcheck\":true,\"rows\":%llu,\"includes_construction\":true,\"excludes_offset_zero\":true,\"fallback_pool\":512,\"cases\":[",h[0]/5*4*h[1]);
  for(unsigned mode=0;mode<5;mode++){
    unsigned reps=100,hist[65]={0},failed=0;uint64_t total=0,rows=0,fb=0,fbc=0,attempts=0;
    double c=cpu(),w=wall();
    for(unsigned r=0;r<reps;r++)for(size_t k=0;k<h[0];k++){
      if(k%5==0)continue;const uint64_t*sh=d+k*stride,*s=sh+h[2];
      for(size_t j=0;j<h[1];j++){
        Result v=run(s,sh,j,pools[mode]);checksum+=v.count;
        if(!r){rows++;total+=v.count;fb+=v.fallback;fbc+=v.fallback_masks;attempts+=v.attempted;if(v.count<65)hist[v.count]++;else failed++;}
      }
    }c=cpu()-c;w=wall()-w;
    printf("%s{\"method\":\"%s\",\"initial_pool\":%u,\"repetitions\":%u,\"cpu_seconds\":%.9f,\"wall_seconds\":%.9f,\"mean_selected\":%.12f,\"fallback_words\":%llu,\"mean_fallback_masks\":%.12f,\"mean_attempted\":%.12f,\"failed\":%u,\"histogram\":{",mode?",":"",pools[mode]?"greedy_then_fallback":"sequential_productive",pools[mode],reps,c,w,(double)total/rows,fb,(double)fbc/rows,(double)attempts/rows,failed);
    unsigned emitted=0;for(unsigned k=0;k<65;k++)if(hist[k])printf("%s\"%u\":%u",emitted++?",":"",k,hist[k]);printf("}}");
  }printf("],\"checksum\":%llu}\n",checksum);free(d);return 0;
}
