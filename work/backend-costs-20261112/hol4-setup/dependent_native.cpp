// Native comparison only: successful execution is not a HOL/Lean proof.
#include <gmpxx.h>
#include <algorithm>
#include <ctime>
#include <iomanip>
#include <iostream>
#include <stdexcept>
#include <utility>
#include <vector>
#include "dependent_data.hpp"

using Complex = std::pair<mpz_class, mpz_class>;
using Vector = std::vector<Complex>;
const mpz_class scale(scale_text);

Vector load(const char* const values[][2], size_t count) {
  Vector result;
  for (size_t i=0; i<count; ++i)
    result.emplace_back(mpz_class(values[i][0]), mpz_class(values[i][1]));
  return result;
}

Vector run(unsigned depth, Vector xs, const Vector& ws) {
  Vector next(xs.size());
  mpz_class t,u,v,rr,ii,qr,qi,numerator,denominator=2*scale;
  for (unsigned d=0; d<depth; ++d) {
    for (size_t j=0; j<ws.size(); ++j) {
      const auto& [ur,ui]=xs[2*j];
      const auto& [vr,vi]=xs[2*j+1];
      const auto& [wr,wi]=ws[j];
      t=wr*(vr+vi); u=vi*(wr+wi); v=vr*(wi-wr);
      rr=t-u; ii=t+v;
      numerator=2*rr+scale;
      mpz_fdiv_q(qr.get_mpz_t(),numerator.get_mpz_t(),denominator.get_mpz_t());
      numerator=2*ii+scale;
      mpz_fdiv_q(qi.get_mpz_t(),numerator.get_mpz_t(),denominator.get_mpz_t());
      next[2*j]={ur+qr,ui+qi};
      next[2*j+1]={ur-qr,ui-qi};
    }
    xs.swap(next);
    std::rotate(xs.begin(),xs.begin()+1,xs.end());
  }
  return xs;
}

mpz_class checksum(const Vector& xs) {
  mpz_class c=0;
  for(auto i=xs.rbegin(); i!=xs.rend(); ++i)
    c=i->first+3*i->second+9*c;
  return c;
}

bool accept(unsigned depth,const Vector& xs,const Vector& ws,
            const mpz_class& bound,const mpz_class& expected) {
  if (scale<=0 || xs.size()!=2*ws.size()) return false;
  Vector ys=run(depth,xs,ws);
  for(const auto& [r,i]:ys)
    if (r < -bound || r > bound || i < -bound || i > bound) return false;
  return checksum(ys)==expected;
}

void require(bool test,const char* message) {
  if (!test) throw std::runtime_error(message);
}

int main(int argc,char** argv) {
  unsigned repetitions=argc>1?std::stoul(argv[1]):100;
  require(repetitions>0,"zero repetitions");
  const Vector xs=load(input_data,128),ws=load(coefficient_data,64);
  for(size_t k=0;k<4;++k) {
    const auto& c=cases[k];
    require(run(c.depth,xs,ws)==load(c.outputs,128),"coordinate mismatch");
    mpz_class b(c.bound),expected(c.checksum);
    for(unsigned sample=0;sample<3;++sample) {
      std::clock_t start=std::clock();
      unsigned accepted=0;
      for(unsigned r=0;r<repetitions;++r)
        accepted+=accept(c.depth,xs,ws,b,expected);
      double cpu=double(std::clock()-start)/CLOCKS_PER_SEC;
      require(accepted==repetitions,"valid case rejected");
      std::cout<<"NATIVE_BLOCK_TIME,"<<c.depth<<","<<sample<<","
               <<std::fixed<<std::setprecision(9)<<cpu<<","<<repetitions<<"\n";
    }
  }
  mpz_class bound(cases[1].bound),expected(cases[1].checksum);
  require(!accept(8,xs,ws,bound,mpz_class(expected+1)),"checksum control failed");
  require(!accept(8,xs,ws,mpz_class(0),expected),"bound control failed");
  require(!accept(7,xs,ws,bound,expected),"depth control failed");
  Vector changed=xs,changed_ws=ws;
  changed[0].first+=1;
  changed_ws[1].first+=scale/8;
  require(!accept(8,changed,ws,bound,expected),"input control failed");
  require(!accept(8,xs,changed_ws,bound,expected),"coefficient control failed");
  std::cout<<"NATIVE_BLOCK_ALL_COORDINATES_AND_CONTROLS_PASS\n";
}
