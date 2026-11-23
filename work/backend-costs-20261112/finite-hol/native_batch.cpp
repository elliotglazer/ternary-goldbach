// Untrusted runtime reference only. It does not produce a HOL or Lean theorem.
#include <gmpxx.h>
#include <algorithm>
#include <chrono>
#include <ctime>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

struct Cert { mpz_class p, a; std::vector<mpz_class> factors; };
struct Input {
  std::vector<Cert> certs;
  std::vector<mpz_class> roots;
  mpz_class target, end;
  std::vector<std::pair<mpz_class,mpz_class>> witnesses;
};
double cpu_seconds() {
  timespec t{}; clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t);
  return double(t.tv_sec)+double(t.tv_nsec)*1e-9;
}
Input read_input(const char* path) {
  std::ifstream in(path); Input d; size_t n,k;
  if (!(in>>n) || n!=1537) throw std::runtime_error("bad node count");
  d.certs.resize(n);
  for (auto& c:d.certs) {
    in>>c.p>>c.a>>k; c.factors.resize(k);
    for(auto& q:c.factors) in>>q;
  }
  in>>n; if(n!=393) throw std::runtime_error("bad root count");
  d.roots.resize(n); for(auto& p:d.roots)in>>p;
  in>>d.target>>d.end>>n;
  if(n!=1024)throw std::runtime_error("bad width");
  d.witnesses.resize(n);for(auto& [p,q]:d.witnesses)in>>p>>q;
  if(!in)throw std::runtime_error("input ended early");
  return d;
}
bool contains(const std::vector<Cert>& cs,const mpz_class& p) {
  auto it=std::lower_bound(cs.begin(),cs.end(),p,
    [](const Cert& c,const mpz_class& q){return c.p<q;});
  return it!=cs.end() && it->p==p;
}
__attribute__((noinline)) bool check_graph(const Input& d) {
  for(const auto& c:d.certs) {
    if(c.p==2)continue;
    if(c.p<=1)return false;
    mpz_class product=1, exponent=c.p-1, residue;
    for(const auto& q:c.factors)product*=q;
    if(product!=exponent)return false;
    for(const auto& q:c.factors)if(q>=c.p || !contains(d.certs,q))return false;
    mpz_powm(residue.get_mpz_t(),c.a.get_mpz_t(),exponent.get_mpz_t(),c.p.get_mpz_t());
    if(residue!=1)return false;
    for(const auto& q:c.factors) {
      if(q==0)return false;
      mpz_class e=exponent/q;
      mpz_powm(residue.get_mpz_t(),c.a.get_mpz_t(),e.get_mpz_t(),c.p.get_mpz_t());
      if(residue==1)return false;
    }
  }
  return true;
}
__attribute__((noinline)) bool check_coverage(const Input& d) {
  if(d.target%2!=0 || d.target+2*d.witnesses.size()!=d.end)return false;
  for(const auto& p:d.roots)if(!contains(d.certs,p))return false;
  mpz_class current=d.target;
  for(const auto& [p,q]:d.witnesses) {
    if(!contains(d.certs,p)||!contains(d.certs,q)||p+q!=current)return false;
    current+=2;
  }
  return true;
}
template<class F> void measure(const char* label,int reps,F f) {
  if(!f())throw std::runtime_error("good input rejected");
  double cpu=cpu_seconds();auto wall=std::chrono::steady_clock::now();
  volatile int accepted=0;
  for(int i=0;i<reps;i++) { asm volatile("" ::: "memory");if(f())accepted++; }
  double elapsed=std::chrono::duration<double>(std::chrono::steady_clock::now()-wall).count();
  if(accepted!=reps)throw std::runtime_error("iteration rejected");
  std::cout<<"NATIVE_BATCH_TIME,"<<label<<","<<reps<<","<<(cpu_seconds()-cpu)/reps
           <<","<<elapsed/reps<<"\n";
}
int main(int argc,char**argv) {
  if(argc!=3)return 2;
  std::cout<<std::fixed<<std::setprecision(9);
  double start=cpu_seconds();Input d=read_input(argv[1]);
  std::cout<<"NATIVE_BATCH_INPUT_CPU,"<<cpu_seconds()-start<<"\n";
  int reps=std::stoi(argv[2]);if(reps<=0)return 2;
  measure("primality",reps,[&]{return check_graph(d);});
  measure("coverage",reps,[&]{return check_coverage(d);});
  Input bad=d;bad.certs[bad.certs.size()/2].a=1;
  if(check_graph(bad))throw std::runtime_error("bad base accepted");
  bad=d;bad.witnesses[0].first+=2;
  if(check_coverage(bad))throw std::runtime_error("bad sum accepted");
  std::cout<<"NATIVE_BATCH_CONTROLS_PASSED\nNATIVE_BATCH_DONE\n";
}
