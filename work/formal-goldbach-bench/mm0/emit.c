/* Native producer for the exact 8-bit/64-bit slice-OR schematic workload.
   Consumes the checked zero-update prefix; emits a complete ordinary MMB. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <string.h>
static unsigned char buffer[1<<20];
static FILE *out;
static uint64_t count;
static void byte(unsigned x) { putc_unlocked(x,out); ++count; }
static void command(unsigned op,uint32_t n) {
  if(!n) byte(op);
  else if(n<256){byte(op|64);byte(n);}
  else if(n<65536){byte(op|128);byte(n);byte(n>>8);}
  else {byte(op|192);byte(n);byte(n>>8);byte(n>>16);byte(n>>24);}
}
static void ref(uint32_t x){command(0x12,x);}
static unsigned vr(unsigned x){return x?x+2:0;}
static uint32_t rnd=20261110;
static unsigned randbyte(void){rnd^=rnd<<13;rnd^=rnd>>17;rnd^=rnd<<5;return rnd&255;}
static double seconds(struct timespec a,struct timespec b){return b.tv_sec-a.tv_sec+(b.tv_nsec-a.tv_nsec)*1e-9;}
int main(int argc,char**argv){
  if(argc<5){fprintf(stderr,"emit prefix output updates proof_decl_offset [or|slice-or] [reset_every] [sparse_level] [bad]\n");return 2;}
  uint32_t n=strtoul(argv[3],0,10),decl=strtoul(argv[4],0,10);
  int onlyor=argc>5&&!strcmp(argv[5],"or");
  unsigned reset=argc>6?strtoul(argv[6],0,10):0,sparse=argc>7?strtoul(argv[7],0,10):1;
  int bad=argc>8&&!strcmp(argv[8],"bad");unsigned lift=onlyor?65540:131076,finish=lift+1+(reset!=0);
  uint64_t *actual=0;size_t actual_len=0;
  if(argc>9){
    if(!onlyor||!reset)return 10;
    FILE *f=fopen(argv[9],"rb");if(!f)return 11;
    fseek(f,0,SEEK_END);long sz=ftell(f);rewind(f);
    if(sz<=0||sz%16)return 12;
    actual=malloc(sz);if(fread(actual,1,sz,f)!=(size_t)sz)return 13;
    fclose(f);actual_len=sz/16;
  }
  FILE *in=fopen(argv[1],"rb");if(!in)return 3;
  fseek(in,0,SEEK_END);size_t plen=ftell(in);rewind(in);
  unsigned char *prefix=malloc(plen);if(fread(prefix,1,plen,in)!=plen)return 4;fclose(in);
  out=fopen(argv[2],"w+b");if(!out)return 5;setvbuf(out,(char*)buffer,_IOFBF,sizeof(buffer));
  struct timespec cs,ce,ws,we;clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&cs);clock_gettime(CLOCK_MONOTONIC,&ws);
  if(fwrite(prefix,1,plen,out)!=plen)return 6;count=plen;
  uint32_t heap=onlyor?65794:131330,trace=1,word=2;
  unsigned a[8]={0},b[9],c[8],r[8];
  for(uint32_t j=0;j<n;j++){
    if(j&&(actual?actual[2*(j%actual_len)+1]:(reset&&j%reset==0))){
      ref(trace);ref(word);ref(trace);command(0x11,264);trace=heap++;
      word=2;ref(word);command(0x10,260);command(0x14,lift+1);memset(a,0,sizeof a);
    }
    for(int i=0;i<(onlyor?8:9);i++){
      if(actual)b[i]=(actual[2*(j%actual_len)]>>(8*i))&255;
      else {b[i]=255;for(unsigned k=0;k<sparse;k++)b[i]&=randbyte();}
    }
    if(onlyor)b[8]=b[7];
    for(int i=0;i<8;i++){c[i]=onlyor?b[i]:((b[i]>>3)|(b[i+1]<<5))&255;r[i]=a[i]|c[i];}
    if(!onlyor)for(int i=0;i<8;i++)ref(65794+b[i]*256+b[i+1]+(bad&&j==0&&i==0));
    for(int i=0;i<8;i++)ref(258+a[i]*256+c[i]+(bad&&onlyor&&j==0&&i==0));
    ref(trace);
    for(int i=0;i<8;i++)ref(vr(a[i]));
    for(int i=0;i<(onlyor?8:9);i++)ref(vr(b[i]));
    if(!onlyor)for(int i=0;i<8;i++)ref(vr(c[i]));
    for(int i=0;i<8;i++)ref(vr(r[i]));
    ref(trace);ref(word);
    for(int i=0;i<9;i++)ref(vr(b[i]));command(0x10,257);
    for(int i=0;i<8;i++)ref(vr(r[i]));command(0x11,256);word=heap++;
    command(0x11,259);trace=heap++;
    ref(word);command(0x10,260);command(0x14,lift);
    memcpy(a,r,sizeof a);
  }
  uint64_t end_updates=count;
  ref(trace);ref(word);command(0x10,261);command(0x14,finish);byte(0);
  uint32_t proof_len=count-decl;for(int i=0;i<5;i++)byte(0);
  fflush(out);fseek(out,decl+1,SEEK_SET);
  unsigned char len[4]={proof_len,proof_len>>8,proof_len>>16,proof_len>>24};
  fwrite(len,1,4,out);fclose(out);
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ce);clock_gettime(CLOCK_MONOTONIC,&we);
  printf("{\"updates\":%u,\"bytes\":%llu,\"update_bytes\":%llu,\"cpu_seconds\":%.9f,\"wall_seconds\":%.9f}\n",n,(unsigned long long)count,(unsigned long long)(end_updates-plen),seconds(cs,ce),seconds(ws,we));
  return 0;
}
