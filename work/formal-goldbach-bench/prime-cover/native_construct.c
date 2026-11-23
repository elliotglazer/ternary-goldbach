/* Reuse platform timing and the two independently checked search routines. */
#define main unused_cached_main
#include "native_greedy.c"
#undef main
static uint64_t slice(const uint64_t *s,uint64_t offset){
  unsigned b=offset&63;size_t i=offset>>6;
  return (s[i]>>b)|(b?(s[i+1]<<(64-b)):0);
}
int main(int argc,char**argv){
  if(argc!=2)return 2;void*f=fopen(argv[1],"rb");if(!f)return 3;
  uint64_t h[4];if(fread(h,8,4,f)!=4)return 4;
  size_t stride=h[2]+h[3];uint64_t*d=malloc(h[0]*stride*8);if(!d)return 5;
  if(fread(d,8,h[0]*stride,f)!=h[0]*stride)return 6;fclose(f);
  uint64_t masks[1024];volatile uint64_t checksum=0;
  printf("{\"includes_slice_construction\":true,\"excludes_offset_zero\":true,\"rows\":%llu,\"cases\":[",h[0]/5*4*h[1]);
  for(unsigned mode=0;mode<4;mode++){
    unsigned n=(mode%2)?1024:512,isseq=mode>=2,reps=isseq?200:20;
    uint64_t total=0,rows=0;unsigned max=0,fail=0;double c=cpu(),w=wall();
    for(unsigned r=0;r<reps;r++)for(size_t k=0;k<h[0];k++){
      if(k%5==0)continue;
      const uint64_t*sh=d+k*stride,*src=sh+h[2];
      for(size_t j=0;j<h[1];j++){
        unsigned value;
        if(isseq){uint64_t rem=~(uint64_t)0;value=999;
          for(unsigned a=0;a<n;a++){rem&=~slice(src,sh[a]+64*j);if(!rem){value=a+1;break;}}
        }else{
          for(unsigned a=0;a<n;a++)masks[a]=slice(src,sh[a]+64*j);
          value=greedy(masks,n);
        }
        checksum+=value;if(!r){rows++;total+=value;if(value>max)max=value;fail+=(value==999);}
      }
    }
    c=cpu()-c;w=wall()-w;
    printf("%s{\"method\":\"%s\",\"pool\":%u,\"repetitions\":%u,\"cpu_seconds\":%.9f,\"wall_seconds\":%.9f,\"mean_count\":%.12f,\"max_count\":%u,\"failures\":%u}",mode?",":"",isseq?"sequential":"greedy",n,reps,c,w,(double)total/rows,max,fail);
  }
  printf("],\"checksum\":%llu}\n",checksum);free(d);return 0;
}
