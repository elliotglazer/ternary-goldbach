import Primes1024
import Data1024
import PrimeBitmapShift
set_option maxRecDepth 65536
set_option maxHeartbeats 0
open PrimeCoverage
namespace FiniteP0N1024
theorem source_primes : PrimeBitmap FiniteData1024.first FiniteData1024.source := by
  have h : PrimeBitmap FiniteData1024.first (((((((((1 <<< 38) ||| (1 <<< 78)) ||| ((1 <<< 81) ||| (1 <<< 84))) ||| (((1 <<< 86) ||| (1 <<< 90)) ||| ((1 <<< 101) ||| (1 <<< 105)))) ||| ((((1 <<< 113) ||| (1 <<< 116)) ||| ((1 <<< 119) ||| (1 <<< 125))) ||| (((1 <<< 158) ||| (1 <<< 165)) ||| ((1 <<< 170) ||| ((1 <<< 174) ||| (1 <<< 176)))))) ||| (((((1 <<< 224) ||| (1 <<< 248)) ||| ((1 <<< 273) ||| (1 <<< 275))) ||| (((1 <<< 276) ||| (1 <<< 279)) ||| ((1 <<< 281) ||| ((1 <<< 311) ||| (1 <<< 333))))) ||| ((((1 <<< 336) ||| (1 <<< 339)) ||| ((1 <<< 345) ||| (1 <<< 360))) ||| (((1 <<< 380) ||| (1 <<< 386)) ||| ((1 <<< 393) ||| ((1 <<< 398) ||| (1 <<< 401))))))) ||| ((((((1 <<< 413) ||| (1 <<< 414)) ||| ((1 <<< 423) ||| (1 <<< 434))) ||| (((1 <<< 464) ||| (1 <<< 470)) ||| ((1 <<< 500) ||| (1 <<< 515)))) ||| ((((1 <<< 525) ||| (1 <<< 534)) ||| ((1 <<< 539) ||| (1 <<< 540))) ||| (((1 <<< 543) ||| (1 <<< 545)) ||| ((1 <<< 548) ||| ((1 <<< 566) ||| (1 <<< 585)))))) ||| (((((1 <<< 590) ||| (1 <<< 591)) ||| ((1 <<< 611) ||| (1 <<< 618))) ||| (((1 <<< 636) ||| (1 <<< 638)) ||| ((1 <<< 651) ||| ((1 <<< 678) ||| (1 <<< 683))))) ||| ((((1 <<< 690) ||| (1 <<< 708)) ||| ((1 <<< 710) ||| (1 <<< 711))) ||| (((1 <<< 728) ||| (1 <<< 738)) ||| ((1 <<< 749) ||| ((1 <<< 759) ||| (1 <<< 770)))))))) ||| (((((((1 <<< 774) ||| (1 <<< 776)) ||| ((1 <<< 783) ||| (1 <<< 794))) ||| (((1 <<< 795) ||| (1 <<< 800)) ||| ((1 <<< 818) ||| (1 <<< 825)))) ||| ((((1 <<< 828) ||| (1 <<< 830)) ||| ((1 <<< 843) ||| (1 <<< 860))) ||| (((1 <<< 869) ||| (1 <<< 870)) ||| ((1 <<< 878) ||| ((1 <<< 968) ||| (1 <<< 981)))))) ||| (((((1 <<< 996) ||| (1 <<< 1008)) ||| ((1 <<< 1016) ||| (1 <<< 1029))) ||| (((1 <<< 1035) ||| (1 <<< 1038)) ||| ((1 <<< 1040) ||| ((1 <<< 1050) ||| (1 <<< 1056))))) ||| ((((1 <<< 1059) ||| (1 <<< 1071)) ||| ((1 <<< 1080) ||| (1 <<< 1085))) ||| (((1 <<< 1095) ||| (1 <<< 1103)) ||| ((1 <<< 1128) ||| ((1 <<< 1133) ||| (1 <<< 1136))))))) ||| ((((((1 <<< 1140) ||| (1 <<< 1145)) ||| ((1 <<< 1169) ||| (1 <<< 1170))) ||| (((1 <<< 1191) ||| (1 <<< 1199)) ||| ((1 <<< 1229) ||| ((1 <<< 1263) ||| (1 <<< 1295))))) ||| ((((1 <<< 1298) ||| (1 <<< 1305)) ||| ((1 <<< 1310) ||| (1 <<< 1316))) ||| (((1 <<< 1350) ||| (1 <<< 1358)) ||| ((1 <<< 1371) ||| ((1 <<< 1383) ||| (1 <<< 1389)))))) ||| (((((1 <<< 1401) ||| (1 <<< 1406)) ||| ((1 <<< 1424) ||| (1 <<< 1428))) ||| (((1 <<< 1430) ||| (1 <<< 1445)) ||| ((1 <<< 1464) ||| ((1 <<< 1481) ||| (1 <<< 1494))))) ||| ((((1 <<< 1505) ||| (1 <<< 1514)) ||| ((1 <<< 1515) ||| (1 <<< 1520))) ||| (((1 <<< 1523) ||| (1 <<< 1548)) ||| ((1 <<< 1565) ||| ((1 <<< 1569) ||| (1 <<< 1574))))))))) ||| ((((((((1 <<< 1586) ||| (1 <<< 1611)) ||| ((1 <<< 1614) ||| (1 <<< 1625))) ||| (((1 <<< 1635) ||| (1 <<< 1653)) ||| ((1 <<< 1656) ||| (1 <<< 1673)))) ||| ((((1 <<< 1679) ||| (1 <<< 1680)) ||| ((1 <<< 1695) ||| (1 <<< 1709))) ||| (((1 <<< 1724) ||| (1 <<< 1728)) ||| ((1 <<< 1736) ||| ((1 <<< 1749) ||| (1 <<< 1775)))))) ||| (((((1 <<< 1778) ||| (1 <<< 1788)) ||| ((1 <<< 1799) ||| (1 <<< 1805))) ||| (((1 <<< 1806) ||| (1 <<< 1823)) ||| ((1 <<< 1826) ||| ((1 <<< 1829) ||| (1 <<< 1851))))) ||| ((((1 <<< 1854) ||| (1 <<< 1856)) ||| ((1 <<< 1875) ||| (1 <<< 1893))) ||| (((1 <<< 1904) ||| (1 <<< 1905)) ||| ((1 <<< 1908) ||| ((1 <<< 1911) ||| (1 <<< 1926))))))) ||| ((((((1 <<< 1950) ||| (1 <<< 1956)) ||| ((1 <<< 1964) ||| (1 <<< 1991))) ||| (((1 <<< 2010) ||| (1 <<< 2018)) ||| ((1 <<< 2033) ||| ((1 <<< 2043) ||| (1 <<< 2046))))) ||| ((((1 <<< 2054) ||| (1 <<< 2060)) ||| ((1 <<< 2066) ||| (1 <<< 2079))) ||| (((1 <<< 2081) ||| (1 <<< 2085)) ||| ((1 <<< 2096) ||| ((1 <<< 2106) ||| (1 <<< 2109)))))) ||| (((((1 <<< 2141) ||| (1 <<< 2156)) ||| ((1 <<< 2159) ||| (1 <<< 2163))) ||| (((1 <<< 2178) ||| (1 <<< 2180)) ||| ((1 <<< 2190) ||| ((1 <<< 2219) ||| (1 <<< 2223))))) ||| ((((1 <<< 2244) ||| (1 <<< 2246)) ||| ((1 <<< 2264) ||| (1 <<< 2283))) ||| (((1 <<< 2291) ||| (1 <<< 2340)) ||| ((1 <<< 2345) ||| ((1 <<< 2346) ||| (1 <<< 2351)))))))) ||| (((((((1 <<< 2376) ||| (1 <<< 2379)) ||| ((1 <<< 2418) ||| (1 <<< 2424))) ||| (((1 <<< 2450) ||| (1 <<< 2481)) ||| ((1 <<< 2486) ||| (1 <<< 2505)))) ||| ((((1 <<< 2510) ||| (1 <<< 2514)) ||| ((1 <<< 2516) ||| (1 <<< 2535))) ||| (((1 <<< 2564) ||| (1 <<< 2571)) ||| ((1 <<< 2579) ||| ((1 <<< 2594) ||| (1 <<< 2598)))))) ||| (((((1 <<< 2615) ||| (1 <<< 2621)) ||| ((1 <<< 2625) ||| (1 <<< 2633))) ||| (((1 <<< 2636) ||| (1 <<< 2654)) ||| ((1 <<< 2655) ||| ((1 <<< 2663) ||| (1 <<< 2664))))) ||| ((((1 <<< 2709) ||| (1 <<< 2718)) ||| ((1 <<< 2724) ||| (1 <<< 2750))) ||| (((1 <<< 2775) ||| (1 <<< 2778)) ||| ((1 <<< 2781) ||| ((1 <<< 2783) ||| (1 <<< 2801))))))) ||| ((((((1 <<< 2816) ||| (1 <<< 2841)) ||| ((1 <<< 2858) ||| (1 <<< 2876))) ||| (((1 <<< 2880) ||| (1 <<< 2900)) ||| ((1 <<< 2901) ||| ((1 <<< 2940) ||| (1 <<< 2963))))) ||| ((((1 <<< 2984) ||| (1 <<< 2999)) ||| ((1 <<< 3003) ||| (1 <<< 3011))) ||| (((1 <<< 3018) ||| (1 <<< 3026)) ||| ((1 <<< 3045) ||| ((1 <<< 3048) ||| (1 <<< 3056)))))) ||| (((((1 <<< 3074) ||| (1 <<< 3081)) ||| ((1 <<< 3084) ||| (1 <<< 3089))) ||| (((1 <<< 3096) ||| (1 <<< 3108)) ||| ((1 <<< 3126) ||| ((1 <<< 3135) ||| (1 <<< 3138))))) ||| ((((1 <<< 3158) ||| (1 <<< 3173)) ||| ((1 <<< 3186) ||| (1 <<< 3195))) ||| (((1 <<< 3213) ||| (1 <<< 3216)) ||| ((1 <<< 3236) ||| ((1 <<< 3243) ||| (1 <<< 3270)))))))))) := (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 38 prime_8589932627) (PrimeBitmap.singleton_shift FiniteData1024.first 78 prime_8589932707)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 81 prime_8589932713) (PrimeBitmap.singleton_shift FiniteData1024.first 84 prime_8589932719))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 86 prime_8589932723) (PrimeBitmap.singleton_shift FiniteData1024.first 90 prime_8589932731)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 101 prime_8589932753) (PrimeBitmap.singleton_shift FiniteData1024.first 105 prime_8589932761)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 113 prime_8589932777) (PrimeBitmap.singleton_shift FiniteData1024.first 116 prime_8589932783)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 119 prime_8589932789) (PrimeBitmap.singleton_shift FiniteData1024.first 125 prime_8589932801))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 158 prime_8589932867) (PrimeBitmap.singleton_shift FiniteData1024.first 165 prime_8589932881)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 170 prime_8589932891) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 174 prime_8589932899) (PrimeBitmap.singleton_shift FiniteData1024.first 176 prime_8589932903)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 224 prime_8589932999) (PrimeBitmap.singleton_shift FiniteData1024.first 248 prime_8589933047)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 273 prime_8589933097) (PrimeBitmap.singleton_shift FiniteData1024.first 275 prime_8589933101))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 276 prime_8589933103) (PrimeBitmap.singleton_shift FiniteData1024.first 279 prime_8589933109)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 281 prime_8589933113) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 311 prime_8589933173) (PrimeBitmap.singleton_shift FiniteData1024.first 333 prime_8589933217))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 336 prime_8589933223) (PrimeBitmap.singleton_shift FiniteData1024.first 339 prime_8589933229)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 345 prime_8589933241) (PrimeBitmap.singleton_shift FiniteData1024.first 360 prime_8589933271))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 380 prime_8589933311) (PrimeBitmap.singleton_shift FiniteData1024.first 386 prime_8589933323)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 393 prime_8589933337) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 398 prime_8589933347) (PrimeBitmap.singleton_shift FiniteData1024.first 401 prime_8589933353))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 413 prime_8589933377) (PrimeBitmap.singleton_shift FiniteData1024.first 414 prime_8589933379)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 423 prime_8589933397) (PrimeBitmap.singleton_shift FiniteData1024.first 434 prime_8589933419))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 464 prime_8589933479) (PrimeBitmap.singleton_shift FiniteData1024.first 470 prime_8589933491)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 500 prime_8589933551) (PrimeBitmap.singleton_shift FiniteData1024.first 515 prime_8589933581)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 525 prime_8589933601) (PrimeBitmap.singleton_shift FiniteData1024.first 534 prime_8589933619)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 539 prime_8589933629) (PrimeBitmap.singleton_shift FiniteData1024.first 540 prime_8589933631))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 543 prime_8589933637) (PrimeBitmap.singleton_shift FiniteData1024.first 545 prime_8589933641)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 548 prime_8589933647) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 566 prime_8589933683) (PrimeBitmap.singleton_shift FiniteData1024.first 585 prime_8589933721)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 590 prime_8589933731) (PrimeBitmap.singleton_shift FiniteData1024.first 591 prime_8589933733)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 611 prime_8589933773) (PrimeBitmap.singleton_shift FiniteData1024.first 618 prime_8589933787))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 636 prime_8589933823) (PrimeBitmap.singleton_shift FiniteData1024.first 638 prime_8589933827)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 651 prime_8589933853) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 678 prime_8589933907) (PrimeBitmap.singleton_shift FiniteData1024.first 683 prime_8589933917))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 690 prime_8589933931) (PrimeBitmap.singleton_shift FiniteData1024.first 708 prime_8589933967)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 710 prime_8589933971) (PrimeBitmap.singleton_shift FiniteData1024.first 711 prime_8589933973))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 728 prime_8589934007) (PrimeBitmap.singleton_shift FiniteData1024.first 738 prime_8589934027)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 749 prime_8589934049) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 759 prime_8589934069) (PrimeBitmap.singleton_shift FiniteData1024.first 770 prime_8589934091)))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 774 prime_8589934099) (PrimeBitmap.singleton_shift FiniteData1024.first 776 prime_8589934103)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 783 prime_8589934117) (PrimeBitmap.singleton_shift FiniteData1024.first 794 prime_8589934139))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 795 prime_8589934141) (PrimeBitmap.singleton_shift FiniteData1024.first 800 prime_8589934151)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 818 prime_8589934187) (PrimeBitmap.singleton_shift FiniteData1024.first 825 prime_8589934201)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 828 prime_8589934207) (PrimeBitmap.singleton_shift FiniteData1024.first 830 prime_8589934211)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 843 prime_8589934237) (PrimeBitmap.singleton_shift FiniteData1024.first 860 prime_8589934271))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 869 prime_8589934289) (PrimeBitmap.singleton_shift FiniteData1024.first 870 prime_8589934291)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 878 prime_8589934307) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 968 prime_8589934487) (PrimeBitmap.singleton_shift FiniteData1024.first 981 prime_8589934513)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 996 prime_8589934543) (PrimeBitmap.singleton_shift FiniteData1024.first 1008 prime_8589934567)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1016 prime_8589934583) (PrimeBitmap.singleton_shift FiniteData1024.first 1029 prime_8589934609))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1035 prime_8589934621) (PrimeBitmap.singleton_shift FiniteData1024.first 1038 prime_8589934627)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1040 prime_8589934631) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1050 prime_8589934651) (PrimeBitmap.singleton_shift FiniteData1024.first 1056 prime_8589934663))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1059 prime_8589934669) (PrimeBitmap.singleton_shift FiniteData1024.first 1071 prime_8589934693)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1080 prime_8589934711) (PrimeBitmap.singleton_shift FiniteData1024.first 1085 prime_8589934721))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1095 prime_8589934741) (PrimeBitmap.singleton_shift FiniteData1024.first 1103 prime_8589934757)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1128 prime_8589934807) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1133 prime_8589934817) (PrimeBitmap.singleton_shift FiniteData1024.first 1136 prime_8589934823))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1140 prime_8589934831) (PrimeBitmap.singleton_shift FiniteData1024.first 1145 prime_8589934841)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1169 prime_8589934889) (PrimeBitmap.singleton_shift FiniteData1024.first 1170 prime_8589934891))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1191 prime_8589934933) (PrimeBitmap.singleton_shift FiniteData1024.first 1199 prime_8589934949)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1229 prime_8589935009) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1263 prime_8589935077) (PrimeBitmap.singleton_shift FiniteData1024.first 1295 prime_8589935141))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1298 prime_8589935147) (PrimeBitmap.singleton_shift FiniteData1024.first 1305 prime_8589935161)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1310 prime_8589935171) (PrimeBitmap.singleton_shift FiniteData1024.first 1316 prime_8589935183))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1350 prime_8589935251) (PrimeBitmap.singleton_shift FiniteData1024.first 1358 prime_8589935267)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1371 prime_8589935293) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1383 prime_8589935317) (PrimeBitmap.singleton_shift FiniteData1024.first 1389 prime_8589935329)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1401 prime_8589935353) (PrimeBitmap.singleton_shift FiniteData1024.first 1406 prime_8589935363)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1424 prime_8589935399) (PrimeBitmap.singleton_shift FiniteData1024.first 1428 prime_8589935407))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1430 prime_8589935411) (PrimeBitmap.singleton_shift FiniteData1024.first 1445 prime_8589935441)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1464 prime_8589935479) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1481 prime_8589935513) (PrimeBitmap.singleton_shift FiniteData1024.first 1494 prime_8589935539))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1505 prime_8589935561) (PrimeBitmap.singleton_shift FiniteData1024.first 1514 prime_8589935579)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1515 prime_8589935581) (PrimeBitmap.singleton_shift FiniteData1024.first 1520 prime_8589935591))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1523 prime_8589935597) (PrimeBitmap.singleton_shift FiniteData1024.first 1548 prime_8589935647)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1565 prime_8589935681) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1569 prime_8589935689) (PrimeBitmap.singleton_shift FiniteData1024.first 1574 prime_8589935699))))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1586 prime_8589935723) (PrimeBitmap.singleton_shift FiniteData1024.first 1611 prime_8589935773)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1614 prime_8589935779) (PrimeBitmap.singleton_shift FiniteData1024.first 1625 prime_8589935801))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1635 prime_8589935821) (PrimeBitmap.singleton_shift FiniteData1024.first 1653 prime_8589935857)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1656 prime_8589935863) (PrimeBitmap.singleton_shift FiniteData1024.first 1673 prime_8589935897)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1679 prime_8589935909) (PrimeBitmap.singleton_shift FiniteData1024.first 1680 prime_8589935911)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1695 prime_8589935941) (PrimeBitmap.singleton_shift FiniteData1024.first 1709 prime_8589935969))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1724 prime_8589935999) (PrimeBitmap.singleton_shift FiniteData1024.first 1728 prime_8589936007)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1736 prime_8589936023) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1749 prime_8589936049) (PrimeBitmap.singleton_shift FiniteData1024.first 1775 prime_8589936101)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1778 prime_8589936107) (PrimeBitmap.singleton_shift FiniteData1024.first 1788 prime_8589936127)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1799 prime_8589936149) (PrimeBitmap.singleton_shift FiniteData1024.first 1805 prime_8589936161))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1806 prime_8589936163) (PrimeBitmap.singleton_shift FiniteData1024.first 1823 prime_8589936197)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1826 prime_8589936203) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1829 prime_8589936209) (PrimeBitmap.singleton_shift FiniteData1024.first 1851 prime_8589936253))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1854 prime_8589936259) (PrimeBitmap.singleton_shift FiniteData1024.first 1856 prime_8589936263)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1875 prime_8589936301) (PrimeBitmap.singleton_shift FiniteData1024.first 1893 prime_8589936337))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1904 prime_8589936359) (PrimeBitmap.singleton_shift FiniteData1024.first 1905 prime_8589936361)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1908 prime_8589936367) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1911 prime_8589936373) (PrimeBitmap.singleton_shift FiniteData1024.first 1926 prime_8589936403))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1950 prime_8589936451) (PrimeBitmap.singleton_shift FiniteData1024.first 1956 prime_8589936463)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 1964 prime_8589936479) (PrimeBitmap.singleton_shift FiniteData1024.first 1991 prime_8589936533))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2010 prime_8589936571) (PrimeBitmap.singleton_shift FiniteData1024.first 2018 prime_8589936587)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2033 prime_8589936617) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2043 prime_8589936637) (PrimeBitmap.singleton_shift FiniteData1024.first 2046 prime_8589936643))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2054 prime_8589936659) (PrimeBitmap.singleton_shift FiniteData1024.first 2060 prime_8589936671)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2066 prime_8589936683) (PrimeBitmap.singleton_shift FiniteData1024.first 2079 prime_8589936709))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2081 prime_8589936713) (PrimeBitmap.singleton_shift FiniteData1024.first 2085 prime_8589936721)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2096 prime_8589936743) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2106 prime_8589936763) (PrimeBitmap.singleton_shift FiniteData1024.first 2109 prime_8589936769)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2141 prime_8589936833) (PrimeBitmap.singleton_shift FiniteData1024.first 2156 prime_8589936863)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2159 prime_8589936869) (PrimeBitmap.singleton_shift FiniteData1024.first 2163 prime_8589936877))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2178 prime_8589936907) (PrimeBitmap.singleton_shift FiniteData1024.first 2180 prime_8589936911)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2190 prime_8589936931) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2219 prime_8589936989) (PrimeBitmap.singleton_shift FiniteData1024.first 2223 prime_8589936997))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2244 prime_8589937039) (PrimeBitmap.singleton_shift FiniteData1024.first 2246 prime_8589937043)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2264 prime_8589937079) (PrimeBitmap.singleton_shift FiniteData1024.first 2283 prime_8589937117))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2291 prime_8589937133) (PrimeBitmap.singleton_shift FiniteData1024.first 2340 prime_8589937231)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2345 prime_8589937241) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2346 prime_8589937243) (PrimeBitmap.singleton_shift FiniteData1024.first 2351 prime_8589937253)))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2376 prime_8589937303) (PrimeBitmap.singleton_shift FiniteData1024.first 2379 prime_8589937309)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2418 prime_8589937387) (PrimeBitmap.singleton_shift FiniteData1024.first 2424 prime_8589937399))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2450 prime_8589937451) (PrimeBitmap.singleton_shift FiniteData1024.first 2481 prime_8589937513)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2486 prime_8589937523) (PrimeBitmap.singleton_shift FiniteData1024.first 2505 prime_8589937561)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2510 prime_8589937571) (PrimeBitmap.singleton_shift FiniteData1024.first 2514 prime_8589937579)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2516 prime_8589937583) (PrimeBitmap.singleton_shift FiniteData1024.first 2535 prime_8589937621))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2564 prime_8589937679) (PrimeBitmap.singleton_shift FiniteData1024.first 2571 prime_8589937693)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2579 prime_8589937709) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2594 prime_8589937739) (PrimeBitmap.singleton_shift FiniteData1024.first 2598 prime_8589937747)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2615 prime_8589937781) (PrimeBitmap.singleton_shift FiniteData1024.first 2621 prime_8589937793)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2625 prime_8589937801) (PrimeBitmap.singleton_shift FiniteData1024.first 2633 prime_8589937817))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2636 prime_8589937823) (PrimeBitmap.singleton_shift FiniteData1024.first 2654 prime_8589937859)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2655 prime_8589937861) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2663 prime_8589937877) (PrimeBitmap.singleton_shift FiniteData1024.first 2664 prime_8589937879))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2709 prime_8589937969) (PrimeBitmap.singleton_shift FiniteData1024.first 2718 prime_8589937987)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2724 prime_8589937999) (PrimeBitmap.singleton_shift FiniteData1024.first 2750 prime_8589938051))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2775 prime_8589938101) (PrimeBitmap.singleton_shift FiniteData1024.first 2778 prime_8589938107)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2781 prime_8589938113) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2783 prime_8589938117) (PrimeBitmap.singleton_shift FiniteData1024.first 2801 prime_8589938153))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2816 prime_8589938183) (PrimeBitmap.singleton_shift FiniteData1024.first 2841 prime_8589938233)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2858 prime_8589938267) (PrimeBitmap.singleton_shift FiniteData1024.first 2876 prime_8589938303))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2880 prime_8589938311) (PrimeBitmap.singleton_shift FiniteData1024.first 2900 prime_8589938351)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2901 prime_8589938353) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2940 prime_8589938431) (PrimeBitmap.singleton_shift FiniteData1024.first 2963 prime_8589938477))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 2984 prime_8589938519) (PrimeBitmap.singleton_shift FiniteData1024.first 2999 prime_8589938549)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3003 prime_8589938557) (PrimeBitmap.singleton_shift FiniteData1024.first 3011 prime_8589938573))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3018 prime_8589938587) (PrimeBitmap.singleton_shift FiniteData1024.first 3026 prime_8589938603)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3045 prime_8589938641) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3048 prime_8589938647) (PrimeBitmap.singleton_shift FiniteData1024.first 3056 prime_8589938663)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3074 prime_8589938699) (PrimeBitmap.singleton_shift FiniteData1024.first 3081 prime_8589938713)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3084 prime_8589938719) (PrimeBitmap.singleton_shift FiniteData1024.first 3089 prime_8589938729))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3096 prime_8589938743) (PrimeBitmap.singleton_shift FiniteData1024.first 3108 prime_8589938767)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3126 prime_8589938803) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3135 prime_8589938821) (PrimeBitmap.singleton_shift FiniteData1024.first 3138 prime_8589938827))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3158 prime_8589938867) (PrimeBitmap.singleton_shift FiniteData1024.first 3173 prime_8589938897)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3186 prime_8589938923) (PrimeBitmap.singleton_shift FiniteData1024.first 3195 prime_8589938941))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3213 prime_8589938977) (PrimeBitmap.singleton_shift FiniteData1024.first 3216 prime_8589938983)) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3236 prime_8589939023) (PrimeBitmap.union (PrimeBitmap.singleton_shift FiniteData1024.first 3243 prime_8589939037) (PrimeBitmap.singleton_shift FiniteData1024.first 3270 prime_8589939091))))))))))
  have heq : (((((((((1 <<< 38) ||| (1 <<< 78)) ||| ((1 <<< 81) ||| (1 <<< 84))) ||| (((1 <<< 86) ||| (1 <<< 90)) ||| ((1 <<< 101) ||| (1 <<< 105)))) ||| ((((1 <<< 113) ||| (1 <<< 116)) ||| ((1 <<< 119) ||| (1 <<< 125))) ||| (((1 <<< 158) ||| (1 <<< 165)) ||| ((1 <<< 170) ||| ((1 <<< 174) ||| (1 <<< 176)))))) ||| (((((1 <<< 224) ||| (1 <<< 248)) ||| ((1 <<< 273) ||| (1 <<< 275))) ||| (((1 <<< 276) ||| (1 <<< 279)) ||| ((1 <<< 281) ||| ((1 <<< 311) ||| (1 <<< 333))))) ||| ((((1 <<< 336) ||| (1 <<< 339)) ||| ((1 <<< 345) ||| (1 <<< 360))) ||| (((1 <<< 380) ||| (1 <<< 386)) ||| ((1 <<< 393) ||| ((1 <<< 398) ||| (1 <<< 401))))))) ||| ((((((1 <<< 413) ||| (1 <<< 414)) ||| ((1 <<< 423) ||| (1 <<< 434))) ||| (((1 <<< 464) ||| (1 <<< 470)) ||| ((1 <<< 500) ||| (1 <<< 515)))) ||| ((((1 <<< 525) ||| (1 <<< 534)) ||| ((1 <<< 539) ||| (1 <<< 540))) ||| (((1 <<< 543) ||| (1 <<< 545)) ||| ((1 <<< 548) ||| ((1 <<< 566) ||| (1 <<< 585)))))) ||| (((((1 <<< 590) ||| (1 <<< 591)) ||| ((1 <<< 611) ||| (1 <<< 618))) ||| (((1 <<< 636) ||| (1 <<< 638)) ||| ((1 <<< 651) ||| ((1 <<< 678) ||| (1 <<< 683))))) ||| ((((1 <<< 690) ||| (1 <<< 708)) ||| ((1 <<< 710) ||| (1 <<< 711))) ||| (((1 <<< 728) ||| (1 <<< 738)) ||| ((1 <<< 749) ||| ((1 <<< 759) ||| (1 <<< 770)))))))) ||| (((((((1 <<< 774) ||| (1 <<< 776)) ||| ((1 <<< 783) ||| (1 <<< 794))) ||| (((1 <<< 795) ||| (1 <<< 800)) ||| ((1 <<< 818) ||| (1 <<< 825)))) ||| ((((1 <<< 828) ||| (1 <<< 830)) ||| ((1 <<< 843) ||| (1 <<< 860))) ||| (((1 <<< 869) ||| (1 <<< 870)) ||| ((1 <<< 878) ||| ((1 <<< 968) ||| (1 <<< 981)))))) ||| (((((1 <<< 996) ||| (1 <<< 1008)) ||| ((1 <<< 1016) ||| (1 <<< 1029))) ||| (((1 <<< 1035) ||| (1 <<< 1038)) ||| ((1 <<< 1040) ||| ((1 <<< 1050) ||| (1 <<< 1056))))) ||| ((((1 <<< 1059) ||| (1 <<< 1071)) ||| ((1 <<< 1080) ||| (1 <<< 1085))) ||| (((1 <<< 1095) ||| (1 <<< 1103)) ||| ((1 <<< 1128) ||| ((1 <<< 1133) ||| (1 <<< 1136))))))) ||| ((((((1 <<< 1140) ||| (1 <<< 1145)) ||| ((1 <<< 1169) ||| (1 <<< 1170))) ||| (((1 <<< 1191) ||| (1 <<< 1199)) ||| ((1 <<< 1229) ||| ((1 <<< 1263) ||| (1 <<< 1295))))) ||| ((((1 <<< 1298) ||| (1 <<< 1305)) ||| ((1 <<< 1310) ||| (1 <<< 1316))) ||| (((1 <<< 1350) ||| (1 <<< 1358)) ||| ((1 <<< 1371) ||| ((1 <<< 1383) ||| (1 <<< 1389)))))) ||| (((((1 <<< 1401) ||| (1 <<< 1406)) ||| ((1 <<< 1424) ||| (1 <<< 1428))) ||| (((1 <<< 1430) ||| (1 <<< 1445)) ||| ((1 <<< 1464) ||| ((1 <<< 1481) ||| (1 <<< 1494))))) ||| ((((1 <<< 1505) ||| (1 <<< 1514)) ||| ((1 <<< 1515) ||| (1 <<< 1520))) ||| (((1 <<< 1523) ||| (1 <<< 1548)) ||| ((1 <<< 1565) ||| ((1 <<< 1569) ||| (1 <<< 1574))))))))) ||| ((((((((1 <<< 1586) ||| (1 <<< 1611)) ||| ((1 <<< 1614) ||| (1 <<< 1625))) ||| (((1 <<< 1635) ||| (1 <<< 1653)) ||| ((1 <<< 1656) ||| (1 <<< 1673)))) ||| ((((1 <<< 1679) ||| (1 <<< 1680)) ||| ((1 <<< 1695) ||| (1 <<< 1709))) ||| (((1 <<< 1724) ||| (1 <<< 1728)) ||| ((1 <<< 1736) ||| ((1 <<< 1749) ||| (1 <<< 1775)))))) ||| (((((1 <<< 1778) ||| (1 <<< 1788)) ||| ((1 <<< 1799) ||| (1 <<< 1805))) ||| (((1 <<< 1806) ||| (1 <<< 1823)) ||| ((1 <<< 1826) ||| ((1 <<< 1829) ||| (1 <<< 1851))))) ||| ((((1 <<< 1854) ||| (1 <<< 1856)) ||| ((1 <<< 1875) ||| (1 <<< 1893))) ||| (((1 <<< 1904) ||| (1 <<< 1905)) ||| ((1 <<< 1908) ||| ((1 <<< 1911) ||| (1 <<< 1926))))))) ||| ((((((1 <<< 1950) ||| (1 <<< 1956)) ||| ((1 <<< 1964) ||| (1 <<< 1991))) ||| (((1 <<< 2010) ||| (1 <<< 2018)) ||| ((1 <<< 2033) ||| ((1 <<< 2043) ||| (1 <<< 2046))))) ||| ((((1 <<< 2054) ||| (1 <<< 2060)) ||| ((1 <<< 2066) ||| (1 <<< 2079))) ||| (((1 <<< 2081) ||| (1 <<< 2085)) ||| ((1 <<< 2096) ||| ((1 <<< 2106) ||| (1 <<< 2109)))))) ||| (((((1 <<< 2141) ||| (1 <<< 2156)) ||| ((1 <<< 2159) ||| (1 <<< 2163))) ||| (((1 <<< 2178) ||| (1 <<< 2180)) ||| ((1 <<< 2190) ||| ((1 <<< 2219) ||| (1 <<< 2223))))) ||| ((((1 <<< 2244) ||| (1 <<< 2246)) ||| ((1 <<< 2264) ||| (1 <<< 2283))) ||| (((1 <<< 2291) ||| (1 <<< 2340)) ||| ((1 <<< 2345) ||| ((1 <<< 2346) ||| (1 <<< 2351)))))))) ||| (((((((1 <<< 2376) ||| (1 <<< 2379)) ||| ((1 <<< 2418) ||| (1 <<< 2424))) ||| (((1 <<< 2450) ||| (1 <<< 2481)) ||| ((1 <<< 2486) ||| (1 <<< 2505)))) ||| ((((1 <<< 2510) ||| (1 <<< 2514)) ||| ((1 <<< 2516) ||| (1 <<< 2535))) ||| (((1 <<< 2564) ||| (1 <<< 2571)) ||| ((1 <<< 2579) ||| ((1 <<< 2594) ||| (1 <<< 2598)))))) ||| (((((1 <<< 2615) ||| (1 <<< 2621)) ||| ((1 <<< 2625) ||| (1 <<< 2633))) ||| (((1 <<< 2636) ||| (1 <<< 2654)) ||| ((1 <<< 2655) ||| ((1 <<< 2663) ||| (1 <<< 2664))))) ||| ((((1 <<< 2709) ||| (1 <<< 2718)) ||| ((1 <<< 2724) ||| (1 <<< 2750))) ||| (((1 <<< 2775) ||| (1 <<< 2778)) ||| ((1 <<< 2781) ||| ((1 <<< 2783) ||| (1 <<< 2801))))))) ||| ((((((1 <<< 2816) ||| (1 <<< 2841)) ||| ((1 <<< 2858) ||| (1 <<< 2876))) ||| (((1 <<< 2880) ||| (1 <<< 2900)) ||| ((1 <<< 2901) ||| ((1 <<< 2940) ||| (1 <<< 2963))))) ||| ((((1 <<< 2984) ||| (1 <<< 2999)) ||| ((1 <<< 3003) ||| (1 <<< 3011))) ||| (((1 <<< 3018) ||| (1 <<< 3026)) ||| ((1 <<< 3045) ||| ((1 <<< 3048) ||| (1 <<< 3056)))))) ||| (((((1 <<< 3074) ||| (1 <<< 3081)) ||| ((1 <<< 3084) ||| (1 <<< 3089))) ||| (((1 <<< 3096) ||| (1 <<< 3108)) ||| ((1 <<< 3126) ||| ((1 <<< 3135) ||| (1 <<< 3138))))) ||| ((((1 <<< 3158) ||| (1 <<< 3173)) ||| ((1 <<< 3186) ||| (1 <<< 3195))) ||| (((1 <<< 3213) ||| (1 <<< 3216)) ||| ((1 <<< 3236) ||| ((1 <<< 3243) ||| (1 <<< 3270)))))))))) = FiniteData1024.source := by decide +kernel
  rw [heq] at h
  exact h
theorem anchor_primes : âˆ€ s âˆˆ FiniteData1024.shifts, (FiniteData1024.target - (FiniteData1024.first + 2 * s)).Prime âˆ§ FiniteData1024.first + 2 * s â‰¤ FiniteData1024.target := by
  intro s hs
  simp only [FiniteData1024.shifts, List.mem_cons, List.not_mem_nil, or_false] at hs
  rcases hs with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15 | h16 | h17 | h18 | h19 | h20 | h21 | h22 | h23 | h24 | h25 | h26 | h27 | h28 | h29 | h30 | h31 | h32 | h33 | h34 | h35 | h36 | h37 | h38 | h39 | h40 | h41 | h42 | h43 | h44 | h45 | h46 | h47 | h48 | h49 | h50 | h51 | h52 | h53 | h54 | h55 | h56 | h57 | h58 | h59 | h60 | h61 | h62 | h63 | h64 | h65 | h66 | h67 | h68 | h69 | h70 | h71 | h72 | h73 | h74 | h75 | h76 | h77 | h78 | h79 | h80 | h81 | h82 | h83 | h84 | h85 | h86 | h87 | h88 | h89 | h90 | h91 | h92 | h93 | h94 | h95 | h96 | h97 | h98 | h99 | h100 | h101 | h102 | h103 | h104 | h105 | h106 | h107 | h108 | h109
  Â· subst s
    exact âŸ¨prime_3999999988766605309, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766605261, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766605193, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766605099, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766605097, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766605091, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766605027, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604853, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604817, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604803, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604653, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604649, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604619, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604503, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604419, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604373, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604359, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604353, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604307, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604287, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604271, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604259, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604217, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604197, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604191, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604187, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604167, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604139, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766604001, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603977, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603929, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603867, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603837, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603819, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603803, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603791, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603777, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603737, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603707, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603699, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603603, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603539, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603501, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603477, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603281, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603273, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603249, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603191, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603189, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603123, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603113, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603099, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603093, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766603021, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602963, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602957, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602819, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602657, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602649, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602621, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602571, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602543, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602531, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602517, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602507, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602501, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602489, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602343, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602333, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602307, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602277, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602259, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602243, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602241, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602213, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602169, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602151, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602147, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602081, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766602061, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601983, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601947, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601923, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601913, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601901, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601889, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601803, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601731, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601607, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601587, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601527, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601511, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601503, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601487, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601481, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601467, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601353, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601349, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601329, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601319, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601233, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601217, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601181, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601107, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601077, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766601041, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766600977, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766600941, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766600881, by decideâŸ©
  Â· subst s
    exact âŸ¨prime_3999999988766600789, by decideâŸ©
theorem coverage : (shiftedUnion FiniteData1024.source FiniteData1024.shifts &&& (2 ^ 1024 - 1)) = 2 ^ 1024 - 1 := by decide +kernel
theorem binary_index : âˆ€ j < 1024, BinaryGoldbach (FiniteData1024.target + 2 * j) :=
  binaryGoldbach_of_bitmap FiniteData1024.first FiniteData1024.source FiniteData1024.target 1024 FiniteData1024.shifts source_primes anchor_primes coverage
theorem binary_interval : âˆ€ n : Nat, 3999999997356537860 â‰¤ n â†’ n < 3999999997356539908 â†’ n % 2 = 0 â†’ âˆƒ p q : Nat, p.Prime âˆ§ q.Prime âˆ§ p + q = n :=
  binaryGoldbach_interval FiniteData1024.target 1024 (by decide) binary_index
end FiniteP0N1024
