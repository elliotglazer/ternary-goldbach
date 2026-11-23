import Primes1024
import Data1024
set_option maxRecDepth 65536
set_option maxHeartbeats 0
open PrimeCoverage
namespace FiniteP0N1024
theorem source_primes : PrimeBitmap FiniteData1024.first FiniteData1024.source := by
  have h : PrimeBitmap FiniteData1024.first (((((((((2 ^ 38) ||| (2 ^ 78)) ||| ((2 ^ 81) ||| (2 ^ 84))) ||| (((2 ^ 86) ||| (2 ^ 90)) ||| ((2 ^ 101) ||| (2 ^ 105)))) ||| ((((2 ^ 113) ||| (2 ^ 116)) ||| ((2 ^ 119) ||| (2 ^ 125))) ||| (((2 ^ 158) ||| (2 ^ 165)) ||| ((2 ^ 170) ||| ((2 ^ 174) ||| (2 ^ 176)))))) ||| (((((2 ^ 224) ||| (2 ^ 248)) ||| ((2 ^ 273) ||| (2 ^ 275))) ||| (((2 ^ 276) ||| (2 ^ 279)) ||| ((2 ^ 281) ||| ((2 ^ 311) ||| (2 ^ 333))))) ||| ((((2 ^ 336) ||| (2 ^ 339)) ||| ((2 ^ 345) ||| (2 ^ 360))) ||| (((2 ^ 380) ||| (2 ^ 386)) ||| ((2 ^ 393) ||| ((2 ^ 398) ||| (2 ^ 401))))))) ||| ((((((2 ^ 413) ||| (2 ^ 414)) ||| ((2 ^ 423) ||| (2 ^ 434))) ||| (((2 ^ 464) ||| (2 ^ 470)) ||| ((2 ^ 500) ||| (2 ^ 515)))) ||| ((((2 ^ 525) ||| (2 ^ 534)) ||| ((2 ^ 539) ||| (2 ^ 540))) ||| (((2 ^ 543) ||| (2 ^ 545)) ||| ((2 ^ 548) ||| ((2 ^ 566) ||| (2 ^ 585)))))) ||| (((((2 ^ 590) ||| (2 ^ 591)) ||| ((2 ^ 611) ||| (2 ^ 618))) ||| (((2 ^ 636) ||| (2 ^ 638)) ||| ((2 ^ 651) ||| ((2 ^ 678) ||| (2 ^ 683))))) ||| ((((2 ^ 690) ||| (2 ^ 708)) ||| ((2 ^ 710) ||| (2 ^ 711))) ||| (((2 ^ 728) ||| (2 ^ 738)) ||| ((2 ^ 749) ||| ((2 ^ 759) ||| (2 ^ 770)))))))) ||| (((((((2 ^ 774) ||| (2 ^ 776)) ||| ((2 ^ 783) ||| (2 ^ 794))) ||| (((2 ^ 795) ||| (2 ^ 800)) ||| ((2 ^ 818) ||| (2 ^ 825)))) ||| ((((2 ^ 828) ||| (2 ^ 830)) ||| ((2 ^ 843) ||| (2 ^ 860))) ||| (((2 ^ 869) ||| (2 ^ 870)) ||| ((2 ^ 878) ||| ((2 ^ 968) ||| (2 ^ 981)))))) ||| (((((2 ^ 996) ||| (2 ^ 1008)) ||| ((2 ^ 1016) ||| (2 ^ 1029))) ||| (((2 ^ 1035) ||| (2 ^ 1038)) ||| ((2 ^ 1040) ||| ((2 ^ 1050) ||| (2 ^ 1056))))) ||| ((((2 ^ 1059) ||| (2 ^ 1071)) ||| ((2 ^ 1080) ||| (2 ^ 1085))) ||| (((2 ^ 1095) ||| (2 ^ 1103)) ||| ((2 ^ 1128) ||| ((2 ^ 1133) ||| (2 ^ 1136))))))) ||| ((((((2 ^ 1140) ||| (2 ^ 1145)) ||| ((2 ^ 1169) ||| (2 ^ 1170))) ||| (((2 ^ 1191) ||| (2 ^ 1199)) ||| ((2 ^ 1229) ||| ((2 ^ 1263) ||| (2 ^ 1295))))) ||| ((((2 ^ 1298) ||| (2 ^ 1305)) ||| ((2 ^ 1310) ||| (2 ^ 1316))) ||| (((2 ^ 1350) ||| (2 ^ 1358)) ||| ((2 ^ 1371) ||| ((2 ^ 1383) ||| (2 ^ 1389)))))) ||| (((((2 ^ 1401) ||| (2 ^ 1406)) ||| ((2 ^ 1424) ||| (2 ^ 1428))) ||| (((2 ^ 1430) ||| (2 ^ 1445)) ||| ((2 ^ 1464) ||| ((2 ^ 1481) ||| (2 ^ 1494))))) ||| ((((2 ^ 1505) ||| (2 ^ 1514)) ||| ((2 ^ 1515) ||| (2 ^ 1520))) ||| (((2 ^ 1523) ||| (2 ^ 1548)) ||| ((2 ^ 1565) ||| ((2 ^ 1569) ||| (2 ^ 1574))))))))) ||| ((((((((2 ^ 1586) ||| (2 ^ 1611)) ||| ((2 ^ 1614) ||| (2 ^ 1625))) ||| (((2 ^ 1635) ||| (2 ^ 1653)) ||| ((2 ^ 1656) ||| (2 ^ 1673)))) ||| ((((2 ^ 1679) ||| (2 ^ 1680)) ||| ((2 ^ 1695) ||| (2 ^ 1709))) ||| (((2 ^ 1724) ||| (2 ^ 1728)) ||| ((2 ^ 1736) ||| ((2 ^ 1749) ||| (2 ^ 1775)))))) ||| (((((2 ^ 1778) ||| (2 ^ 1788)) ||| ((2 ^ 1799) ||| (2 ^ 1805))) ||| (((2 ^ 1806) ||| (2 ^ 1823)) ||| ((2 ^ 1826) ||| ((2 ^ 1829) ||| (2 ^ 1851))))) ||| ((((2 ^ 1854) ||| (2 ^ 1856)) ||| ((2 ^ 1875) ||| (2 ^ 1893))) ||| (((2 ^ 1904) ||| (2 ^ 1905)) ||| ((2 ^ 1908) ||| ((2 ^ 1911) ||| (2 ^ 1926))))))) ||| ((((((2 ^ 1950) ||| (2 ^ 1956)) ||| ((2 ^ 1964) ||| (2 ^ 1991))) ||| (((2 ^ 2010) ||| (2 ^ 2018)) ||| ((2 ^ 2033) ||| ((2 ^ 2043) ||| (2 ^ 2046))))) ||| ((((2 ^ 2054) ||| (2 ^ 2060)) ||| ((2 ^ 2066) ||| (2 ^ 2079))) ||| (((2 ^ 2081) ||| (2 ^ 2085)) ||| ((2 ^ 2096) ||| ((2 ^ 2106) ||| (2 ^ 2109)))))) ||| (((((2 ^ 2141) ||| (2 ^ 2156)) ||| ((2 ^ 2159) ||| (2 ^ 2163))) ||| (((2 ^ 2178) ||| (2 ^ 2180)) ||| ((2 ^ 2190) ||| ((2 ^ 2219) ||| (2 ^ 2223))))) ||| ((((2 ^ 2244) ||| (2 ^ 2246)) ||| ((2 ^ 2264) ||| (2 ^ 2283))) ||| (((2 ^ 2291) ||| (2 ^ 2340)) ||| ((2 ^ 2345) ||| ((2 ^ 2346) ||| (2 ^ 2351)))))))) ||| (((((((2 ^ 2376) ||| (2 ^ 2379)) ||| ((2 ^ 2418) ||| (2 ^ 2424))) ||| (((2 ^ 2450) ||| (2 ^ 2481)) ||| ((2 ^ 2486) ||| (2 ^ 2505)))) ||| ((((2 ^ 2510) ||| (2 ^ 2514)) ||| ((2 ^ 2516) ||| (2 ^ 2535))) ||| (((2 ^ 2564) ||| (2 ^ 2571)) ||| ((2 ^ 2579) ||| ((2 ^ 2594) ||| (2 ^ 2598)))))) ||| (((((2 ^ 2615) ||| (2 ^ 2621)) ||| ((2 ^ 2625) ||| (2 ^ 2633))) ||| (((2 ^ 2636) ||| (2 ^ 2654)) ||| ((2 ^ 2655) ||| ((2 ^ 2663) ||| (2 ^ 2664))))) ||| ((((2 ^ 2709) ||| (2 ^ 2718)) ||| ((2 ^ 2724) ||| (2 ^ 2750))) ||| (((2 ^ 2775) ||| (2 ^ 2778)) ||| ((2 ^ 2781) ||| ((2 ^ 2783) ||| (2 ^ 2801))))))) ||| ((((((2 ^ 2816) ||| (2 ^ 2841)) ||| ((2 ^ 2858) ||| (2 ^ 2876))) ||| (((2 ^ 2880) ||| (2 ^ 2900)) ||| ((2 ^ 2901) ||| ((2 ^ 2940) ||| (2 ^ 2963))))) ||| ((((2 ^ 2984) ||| (2 ^ 2999)) ||| ((2 ^ 3003) ||| (2 ^ 3011))) ||| (((2 ^ 3018) ||| (2 ^ 3026)) ||| ((2 ^ 3045) ||| ((2 ^ 3048) ||| (2 ^ 3056)))))) ||| (((((2 ^ 3074) ||| (2 ^ 3081)) ||| ((2 ^ 3084) ||| (2 ^ 3089))) ||| (((2 ^ 3096) ||| (2 ^ 3108)) ||| ((2 ^ 3126) ||| ((2 ^ 3135) ||| (2 ^ 3138))))) ||| ((((2 ^ 3158) ||| (2 ^ 3173)) ||| ((2 ^ 3186) ||| (2 ^ 3195))) ||| (((2 ^ 3213) ||| (2 ^ 3216)) ||| ((2 ^ 3236) ||| ((2 ^ 3243) ||| (2 ^ 3270)))))))))) := (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 38 prime_8589932627) (PrimeBitmap.singleton FiniteData1024.first 78 prime_8589932707)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 81 prime_8589932713) (PrimeBitmap.singleton FiniteData1024.first 84 prime_8589932719))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 86 prime_8589932723) (PrimeBitmap.singleton FiniteData1024.first 90 prime_8589932731)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 101 prime_8589932753) (PrimeBitmap.singleton FiniteData1024.first 105 prime_8589932761)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 113 prime_8589932777) (PrimeBitmap.singleton FiniteData1024.first 116 prime_8589932783)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 119 prime_8589932789) (PrimeBitmap.singleton FiniteData1024.first 125 prime_8589932801))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 158 prime_8589932867) (PrimeBitmap.singleton FiniteData1024.first 165 prime_8589932881)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 170 prime_8589932891) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 174 prime_8589932899) (PrimeBitmap.singleton FiniteData1024.first 176 prime_8589932903)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 224 prime_8589932999) (PrimeBitmap.singleton FiniteData1024.first 248 prime_8589933047)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 273 prime_8589933097) (PrimeBitmap.singleton FiniteData1024.first 275 prime_8589933101))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 276 prime_8589933103) (PrimeBitmap.singleton FiniteData1024.first 279 prime_8589933109)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 281 prime_8589933113) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 311 prime_8589933173) (PrimeBitmap.singleton FiniteData1024.first 333 prime_8589933217))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 336 prime_8589933223) (PrimeBitmap.singleton FiniteData1024.first 339 prime_8589933229)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 345 prime_8589933241) (PrimeBitmap.singleton FiniteData1024.first 360 prime_8589933271))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 380 prime_8589933311) (PrimeBitmap.singleton FiniteData1024.first 386 prime_8589933323)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 393 prime_8589933337) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 398 prime_8589933347) (PrimeBitmap.singleton FiniteData1024.first 401 prime_8589933353))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 413 prime_8589933377) (PrimeBitmap.singleton FiniteData1024.first 414 prime_8589933379)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 423 prime_8589933397) (PrimeBitmap.singleton FiniteData1024.first 434 prime_8589933419))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 464 prime_8589933479) (PrimeBitmap.singleton FiniteData1024.first 470 prime_8589933491)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 500 prime_8589933551) (PrimeBitmap.singleton FiniteData1024.first 515 prime_8589933581)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 525 prime_8589933601) (PrimeBitmap.singleton FiniteData1024.first 534 prime_8589933619)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 539 prime_8589933629) (PrimeBitmap.singleton FiniteData1024.first 540 prime_8589933631))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 543 prime_8589933637) (PrimeBitmap.singleton FiniteData1024.first 545 prime_8589933641)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 548 prime_8589933647) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 566 prime_8589933683) (PrimeBitmap.singleton FiniteData1024.first 585 prime_8589933721)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 590 prime_8589933731) (PrimeBitmap.singleton FiniteData1024.first 591 prime_8589933733)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 611 prime_8589933773) (PrimeBitmap.singleton FiniteData1024.first 618 prime_8589933787))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 636 prime_8589933823) (PrimeBitmap.singleton FiniteData1024.first 638 prime_8589933827)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 651 prime_8589933853) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 678 prime_8589933907) (PrimeBitmap.singleton FiniteData1024.first 683 prime_8589933917))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 690 prime_8589933931) (PrimeBitmap.singleton FiniteData1024.first 708 prime_8589933967)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 710 prime_8589933971) (PrimeBitmap.singleton FiniteData1024.first 711 prime_8589933973))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 728 prime_8589934007) (PrimeBitmap.singleton FiniteData1024.first 738 prime_8589934027)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 749 prime_8589934049) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 759 prime_8589934069) (PrimeBitmap.singleton FiniteData1024.first 770 prime_8589934091)))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 774 prime_8589934099) (PrimeBitmap.singleton FiniteData1024.first 776 prime_8589934103)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 783 prime_8589934117) (PrimeBitmap.singleton FiniteData1024.first 794 prime_8589934139))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 795 prime_8589934141) (PrimeBitmap.singleton FiniteData1024.first 800 prime_8589934151)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 818 prime_8589934187) (PrimeBitmap.singleton FiniteData1024.first 825 prime_8589934201)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 828 prime_8589934207) (PrimeBitmap.singleton FiniteData1024.first 830 prime_8589934211)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 843 prime_8589934237) (PrimeBitmap.singleton FiniteData1024.first 860 prime_8589934271))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 869 prime_8589934289) (PrimeBitmap.singleton FiniteData1024.first 870 prime_8589934291)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 878 prime_8589934307) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 968 prime_8589934487) (PrimeBitmap.singleton FiniteData1024.first 981 prime_8589934513)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 996 prime_8589934543) (PrimeBitmap.singleton FiniteData1024.first 1008 prime_8589934567)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1016 prime_8589934583) (PrimeBitmap.singleton FiniteData1024.first 1029 prime_8589934609))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1035 prime_8589934621) (PrimeBitmap.singleton FiniteData1024.first 1038 prime_8589934627)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1040 prime_8589934631) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1050 prime_8589934651) (PrimeBitmap.singleton FiniteData1024.first 1056 prime_8589934663))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1059 prime_8589934669) (PrimeBitmap.singleton FiniteData1024.first 1071 prime_8589934693)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1080 prime_8589934711) (PrimeBitmap.singleton FiniteData1024.first 1085 prime_8589934721))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1095 prime_8589934741) (PrimeBitmap.singleton FiniteData1024.first 1103 prime_8589934757)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1128 prime_8589934807) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1133 prime_8589934817) (PrimeBitmap.singleton FiniteData1024.first 1136 prime_8589934823))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1140 prime_8589934831) (PrimeBitmap.singleton FiniteData1024.first 1145 prime_8589934841)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1169 prime_8589934889) (PrimeBitmap.singleton FiniteData1024.first 1170 prime_8589934891))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1191 prime_8589934933) (PrimeBitmap.singleton FiniteData1024.first 1199 prime_8589934949)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1229 prime_8589935009) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1263 prime_8589935077) (PrimeBitmap.singleton FiniteData1024.first 1295 prime_8589935141))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1298 prime_8589935147) (PrimeBitmap.singleton FiniteData1024.first 1305 prime_8589935161)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1310 prime_8589935171) (PrimeBitmap.singleton FiniteData1024.first 1316 prime_8589935183))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1350 prime_8589935251) (PrimeBitmap.singleton FiniteData1024.first 1358 prime_8589935267)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1371 prime_8589935293) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1383 prime_8589935317) (PrimeBitmap.singleton FiniteData1024.first 1389 prime_8589935329)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1401 prime_8589935353) (PrimeBitmap.singleton FiniteData1024.first 1406 prime_8589935363)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1424 prime_8589935399) (PrimeBitmap.singleton FiniteData1024.first 1428 prime_8589935407))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1430 prime_8589935411) (PrimeBitmap.singleton FiniteData1024.first 1445 prime_8589935441)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1464 prime_8589935479) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1481 prime_8589935513) (PrimeBitmap.singleton FiniteData1024.first 1494 prime_8589935539))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1505 prime_8589935561) (PrimeBitmap.singleton FiniteData1024.first 1514 prime_8589935579)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1515 prime_8589935581) (PrimeBitmap.singleton FiniteData1024.first 1520 prime_8589935591))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1523 prime_8589935597) (PrimeBitmap.singleton FiniteData1024.first 1548 prime_8589935647)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1565 prime_8589935681) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1569 prime_8589935689) (PrimeBitmap.singleton FiniteData1024.first 1574 prime_8589935699))))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1586 prime_8589935723) (PrimeBitmap.singleton FiniteData1024.first 1611 prime_8589935773)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1614 prime_8589935779) (PrimeBitmap.singleton FiniteData1024.first 1625 prime_8589935801))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1635 prime_8589935821) (PrimeBitmap.singleton FiniteData1024.first 1653 prime_8589935857)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1656 prime_8589935863) (PrimeBitmap.singleton FiniteData1024.first 1673 prime_8589935897)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1679 prime_8589935909) (PrimeBitmap.singleton FiniteData1024.first 1680 prime_8589935911)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1695 prime_8589935941) (PrimeBitmap.singleton FiniteData1024.first 1709 prime_8589935969))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1724 prime_8589935999) (PrimeBitmap.singleton FiniteData1024.first 1728 prime_8589936007)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1736 prime_8589936023) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1749 prime_8589936049) (PrimeBitmap.singleton FiniteData1024.first 1775 prime_8589936101)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1778 prime_8589936107) (PrimeBitmap.singleton FiniteData1024.first 1788 prime_8589936127)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1799 prime_8589936149) (PrimeBitmap.singleton FiniteData1024.first 1805 prime_8589936161))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1806 prime_8589936163) (PrimeBitmap.singleton FiniteData1024.first 1823 prime_8589936197)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1826 prime_8589936203) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1829 prime_8589936209) (PrimeBitmap.singleton FiniteData1024.first 1851 prime_8589936253))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1854 prime_8589936259) (PrimeBitmap.singleton FiniteData1024.first 1856 prime_8589936263)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1875 prime_8589936301) (PrimeBitmap.singleton FiniteData1024.first 1893 prime_8589936337))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1904 prime_8589936359) (PrimeBitmap.singleton FiniteData1024.first 1905 prime_8589936361)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1908 prime_8589936367) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1911 prime_8589936373) (PrimeBitmap.singleton FiniteData1024.first 1926 prime_8589936403))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1950 prime_8589936451) (PrimeBitmap.singleton FiniteData1024.first 1956 prime_8589936463)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 1964 prime_8589936479) (PrimeBitmap.singleton FiniteData1024.first 1991 prime_8589936533))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2010 prime_8589936571) (PrimeBitmap.singleton FiniteData1024.first 2018 prime_8589936587)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2033 prime_8589936617) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2043 prime_8589936637) (PrimeBitmap.singleton FiniteData1024.first 2046 prime_8589936643))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2054 prime_8589936659) (PrimeBitmap.singleton FiniteData1024.first 2060 prime_8589936671)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2066 prime_8589936683) (PrimeBitmap.singleton FiniteData1024.first 2079 prime_8589936709))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2081 prime_8589936713) (PrimeBitmap.singleton FiniteData1024.first 2085 prime_8589936721)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2096 prime_8589936743) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2106 prime_8589936763) (PrimeBitmap.singleton FiniteData1024.first 2109 prime_8589936769)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2141 prime_8589936833) (PrimeBitmap.singleton FiniteData1024.first 2156 prime_8589936863)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2159 prime_8589936869) (PrimeBitmap.singleton FiniteData1024.first 2163 prime_8589936877))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2178 prime_8589936907) (PrimeBitmap.singleton FiniteData1024.first 2180 prime_8589936911)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2190 prime_8589936931) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2219 prime_8589936989) (PrimeBitmap.singleton FiniteData1024.first 2223 prime_8589936997))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2244 prime_8589937039) (PrimeBitmap.singleton FiniteData1024.first 2246 prime_8589937043)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2264 prime_8589937079) (PrimeBitmap.singleton FiniteData1024.first 2283 prime_8589937117))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2291 prime_8589937133) (PrimeBitmap.singleton FiniteData1024.first 2340 prime_8589937231)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2345 prime_8589937241) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2346 prime_8589937243) (PrimeBitmap.singleton FiniteData1024.first 2351 prime_8589937253)))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2376 prime_8589937303) (PrimeBitmap.singleton FiniteData1024.first 2379 prime_8589937309)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2418 prime_8589937387) (PrimeBitmap.singleton FiniteData1024.first 2424 prime_8589937399))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2450 prime_8589937451) (PrimeBitmap.singleton FiniteData1024.first 2481 prime_8589937513)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2486 prime_8589937523) (PrimeBitmap.singleton FiniteData1024.first 2505 prime_8589937561)))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2510 prime_8589937571) (PrimeBitmap.singleton FiniteData1024.first 2514 prime_8589937579)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2516 prime_8589937583) (PrimeBitmap.singleton FiniteData1024.first 2535 prime_8589937621))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2564 prime_8589937679) (PrimeBitmap.singleton FiniteData1024.first 2571 prime_8589937693)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2579 prime_8589937709) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2594 prime_8589937739) (PrimeBitmap.singleton FiniteData1024.first 2598 prime_8589937747)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2615 prime_8589937781) (PrimeBitmap.singleton FiniteData1024.first 2621 prime_8589937793)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2625 prime_8589937801) (PrimeBitmap.singleton FiniteData1024.first 2633 prime_8589937817))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2636 prime_8589937823) (PrimeBitmap.singleton FiniteData1024.first 2654 prime_8589937859)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2655 prime_8589937861) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2663 prime_8589937877) (PrimeBitmap.singleton FiniteData1024.first 2664 prime_8589937879))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2709 prime_8589937969) (PrimeBitmap.singleton FiniteData1024.first 2718 prime_8589937987)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2724 prime_8589937999) (PrimeBitmap.singleton FiniteData1024.first 2750 prime_8589938051))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2775 prime_8589938101) (PrimeBitmap.singleton FiniteData1024.first 2778 prime_8589938107)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2781 prime_8589938113) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2783 prime_8589938117) (PrimeBitmap.singleton FiniteData1024.first 2801 prime_8589938153))))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2816 prime_8589938183) (PrimeBitmap.singleton FiniteData1024.first 2841 prime_8589938233)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2858 prime_8589938267) (PrimeBitmap.singleton FiniteData1024.first 2876 prime_8589938303))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2880 prime_8589938311) (PrimeBitmap.singleton FiniteData1024.first 2900 prime_8589938351)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2901 prime_8589938353) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2940 prime_8589938431) (PrimeBitmap.singleton FiniteData1024.first 2963 prime_8589938477))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 2984 prime_8589938519) (PrimeBitmap.singleton FiniteData1024.first 2999 prime_8589938549)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3003 prime_8589938557) (PrimeBitmap.singleton FiniteData1024.first 3011 prime_8589938573))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3018 prime_8589938587) (PrimeBitmap.singleton FiniteData1024.first 3026 prime_8589938603)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3045 prime_8589938641) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3048 prime_8589938647) (PrimeBitmap.singleton FiniteData1024.first 3056 prime_8589938663)))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3074 prime_8589938699) (PrimeBitmap.singleton FiniteData1024.first 3081 prime_8589938713)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3084 prime_8589938719) (PrimeBitmap.singleton FiniteData1024.first 3089 prime_8589938729))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3096 prime_8589938743) (PrimeBitmap.singleton FiniteData1024.first 3108 prime_8589938767)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3126 prime_8589938803) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3135 prime_8589938821) (PrimeBitmap.singleton FiniteData1024.first 3138 prime_8589938827))))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3158 prime_8589938867) (PrimeBitmap.singleton FiniteData1024.first 3173 prime_8589938897)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3186 prime_8589938923) (PrimeBitmap.singleton FiniteData1024.first 3195 prime_8589938941))) (PrimeBitmap.union (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3213 prime_8589938977) (PrimeBitmap.singleton FiniteData1024.first 3216 prime_8589938983)) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3236 prime_8589939023) (PrimeBitmap.union (PrimeBitmap.singleton FiniteData1024.first 3243 prime_8589939037) (PrimeBitmap.singleton FiniteData1024.first 3270 prime_8589939091))))))))))
  have heq : (((((((((2 ^ 38) ||| (2 ^ 78)) ||| ((2 ^ 81) ||| (2 ^ 84))) ||| (((2 ^ 86) ||| (2 ^ 90)) ||| ((2 ^ 101) ||| (2 ^ 105)))) ||| ((((2 ^ 113) ||| (2 ^ 116)) ||| ((2 ^ 119) ||| (2 ^ 125))) ||| (((2 ^ 158) ||| (2 ^ 165)) ||| ((2 ^ 170) ||| ((2 ^ 174) ||| (2 ^ 176)))))) ||| (((((2 ^ 224) ||| (2 ^ 248)) ||| ((2 ^ 273) ||| (2 ^ 275))) ||| (((2 ^ 276) ||| (2 ^ 279)) ||| ((2 ^ 281) ||| ((2 ^ 311) ||| (2 ^ 333))))) ||| ((((2 ^ 336) ||| (2 ^ 339)) ||| ((2 ^ 345) ||| (2 ^ 360))) ||| (((2 ^ 380) ||| (2 ^ 386)) ||| ((2 ^ 393) ||| ((2 ^ 398) ||| (2 ^ 401))))))) ||| ((((((2 ^ 413) ||| (2 ^ 414)) ||| ((2 ^ 423) ||| (2 ^ 434))) ||| (((2 ^ 464) ||| (2 ^ 470)) ||| ((2 ^ 500) ||| (2 ^ 515)))) ||| ((((2 ^ 525) ||| (2 ^ 534)) ||| ((2 ^ 539) ||| (2 ^ 540))) ||| (((2 ^ 543) ||| (2 ^ 545)) ||| ((2 ^ 548) ||| ((2 ^ 566) ||| (2 ^ 585)))))) ||| (((((2 ^ 590) ||| (2 ^ 591)) ||| ((2 ^ 611) ||| (2 ^ 618))) ||| (((2 ^ 636) ||| (2 ^ 638)) ||| ((2 ^ 651) ||| ((2 ^ 678) ||| (2 ^ 683))))) ||| ((((2 ^ 690) ||| (2 ^ 708)) ||| ((2 ^ 710) ||| (2 ^ 711))) ||| (((2 ^ 728) ||| (2 ^ 738)) ||| ((2 ^ 749) ||| ((2 ^ 759) ||| (2 ^ 770)))))))) ||| (((((((2 ^ 774) ||| (2 ^ 776)) ||| ((2 ^ 783) ||| (2 ^ 794))) ||| (((2 ^ 795) ||| (2 ^ 800)) ||| ((2 ^ 818) ||| (2 ^ 825)))) ||| ((((2 ^ 828) ||| (2 ^ 830)) ||| ((2 ^ 843) ||| (2 ^ 860))) ||| (((2 ^ 869) ||| (2 ^ 870)) ||| ((2 ^ 878) ||| ((2 ^ 968) ||| (2 ^ 981)))))) ||| (((((2 ^ 996) ||| (2 ^ 1008)) ||| ((2 ^ 1016) ||| (2 ^ 1029))) ||| (((2 ^ 1035) ||| (2 ^ 1038)) ||| ((2 ^ 1040) ||| ((2 ^ 1050) ||| (2 ^ 1056))))) ||| ((((2 ^ 1059) ||| (2 ^ 1071)) ||| ((2 ^ 1080) ||| (2 ^ 1085))) ||| (((2 ^ 1095) ||| (2 ^ 1103)) ||| ((2 ^ 1128) ||| ((2 ^ 1133) ||| (2 ^ 1136))))))) ||| ((((((2 ^ 1140) ||| (2 ^ 1145)) ||| ((2 ^ 1169) ||| (2 ^ 1170))) ||| (((2 ^ 1191) ||| (2 ^ 1199)) ||| ((2 ^ 1229) ||| ((2 ^ 1263) ||| (2 ^ 1295))))) ||| ((((2 ^ 1298) ||| (2 ^ 1305)) ||| ((2 ^ 1310) ||| (2 ^ 1316))) ||| (((2 ^ 1350) ||| (2 ^ 1358)) ||| ((2 ^ 1371) ||| ((2 ^ 1383) ||| (2 ^ 1389)))))) ||| (((((2 ^ 1401) ||| (2 ^ 1406)) ||| ((2 ^ 1424) ||| (2 ^ 1428))) ||| (((2 ^ 1430) ||| (2 ^ 1445)) ||| ((2 ^ 1464) ||| ((2 ^ 1481) ||| (2 ^ 1494))))) ||| ((((2 ^ 1505) ||| (2 ^ 1514)) ||| ((2 ^ 1515) ||| (2 ^ 1520))) ||| (((2 ^ 1523) ||| (2 ^ 1548)) ||| ((2 ^ 1565) ||| ((2 ^ 1569) ||| (2 ^ 1574))))))))) ||| ((((((((2 ^ 1586) ||| (2 ^ 1611)) ||| ((2 ^ 1614) ||| (2 ^ 1625))) ||| (((2 ^ 1635) ||| (2 ^ 1653)) ||| ((2 ^ 1656) ||| (2 ^ 1673)))) ||| ((((2 ^ 1679) ||| (2 ^ 1680)) ||| ((2 ^ 1695) ||| (2 ^ 1709))) ||| (((2 ^ 1724) ||| (2 ^ 1728)) ||| ((2 ^ 1736) ||| ((2 ^ 1749) ||| (2 ^ 1775)))))) ||| (((((2 ^ 1778) ||| (2 ^ 1788)) ||| ((2 ^ 1799) ||| (2 ^ 1805))) ||| (((2 ^ 1806) ||| (2 ^ 1823)) ||| ((2 ^ 1826) ||| ((2 ^ 1829) ||| (2 ^ 1851))))) ||| ((((2 ^ 1854) ||| (2 ^ 1856)) ||| ((2 ^ 1875) ||| (2 ^ 1893))) ||| (((2 ^ 1904) ||| (2 ^ 1905)) ||| ((2 ^ 1908) ||| ((2 ^ 1911) ||| (2 ^ 1926))))))) ||| ((((((2 ^ 1950) ||| (2 ^ 1956)) ||| ((2 ^ 1964) ||| (2 ^ 1991))) ||| (((2 ^ 2010) ||| (2 ^ 2018)) ||| ((2 ^ 2033) ||| ((2 ^ 2043) ||| (2 ^ 2046))))) ||| ((((2 ^ 2054) ||| (2 ^ 2060)) ||| ((2 ^ 2066) ||| (2 ^ 2079))) ||| (((2 ^ 2081) ||| (2 ^ 2085)) ||| ((2 ^ 2096) ||| ((2 ^ 2106) ||| (2 ^ 2109)))))) ||| (((((2 ^ 2141) ||| (2 ^ 2156)) ||| ((2 ^ 2159) ||| (2 ^ 2163))) ||| (((2 ^ 2178) ||| (2 ^ 2180)) ||| ((2 ^ 2190) ||| ((2 ^ 2219) ||| (2 ^ 2223))))) ||| ((((2 ^ 2244) ||| (2 ^ 2246)) ||| ((2 ^ 2264) ||| (2 ^ 2283))) ||| (((2 ^ 2291) ||| (2 ^ 2340)) ||| ((2 ^ 2345) ||| ((2 ^ 2346) ||| (2 ^ 2351)))))))) ||| (((((((2 ^ 2376) ||| (2 ^ 2379)) ||| ((2 ^ 2418) ||| (2 ^ 2424))) ||| (((2 ^ 2450) ||| (2 ^ 2481)) ||| ((2 ^ 2486) ||| (2 ^ 2505)))) ||| ((((2 ^ 2510) ||| (2 ^ 2514)) ||| ((2 ^ 2516) ||| (2 ^ 2535))) ||| (((2 ^ 2564) ||| (2 ^ 2571)) ||| ((2 ^ 2579) ||| ((2 ^ 2594) ||| (2 ^ 2598)))))) ||| (((((2 ^ 2615) ||| (2 ^ 2621)) ||| ((2 ^ 2625) ||| (2 ^ 2633))) ||| (((2 ^ 2636) ||| (2 ^ 2654)) ||| ((2 ^ 2655) ||| ((2 ^ 2663) ||| (2 ^ 2664))))) ||| ((((2 ^ 2709) ||| (2 ^ 2718)) ||| ((2 ^ 2724) ||| (2 ^ 2750))) ||| (((2 ^ 2775) ||| (2 ^ 2778)) ||| ((2 ^ 2781) ||| ((2 ^ 2783) ||| (2 ^ 2801))))))) ||| ((((((2 ^ 2816) ||| (2 ^ 2841)) ||| ((2 ^ 2858) ||| (2 ^ 2876))) ||| (((2 ^ 2880) ||| (2 ^ 2900)) ||| ((2 ^ 2901) ||| ((2 ^ 2940) ||| (2 ^ 2963))))) ||| ((((2 ^ 2984) ||| (2 ^ 2999)) ||| ((2 ^ 3003) ||| (2 ^ 3011))) ||| (((2 ^ 3018) ||| (2 ^ 3026)) ||| ((2 ^ 3045) ||| ((2 ^ 3048) ||| (2 ^ 3056)))))) ||| (((((2 ^ 3074) ||| (2 ^ 3081)) ||| ((2 ^ 3084) ||| (2 ^ 3089))) ||| (((2 ^ 3096) ||| (2 ^ 3108)) ||| ((2 ^ 3126) ||| ((2 ^ 3135) ||| (2 ^ 3138))))) ||| ((((2 ^ 3158) ||| (2 ^ 3173)) ||| ((2 ^ 3186) ||| (2 ^ 3195))) ||| (((2 ^ 3213) ||| (2 ^ 3216)) ||| ((2 ^ 3236) ||| ((2 ^ 3243) ||| (2 ^ 3270)))))))))) = FiniteData1024.source := by decide +kernel
  rw [heq] at h
  exact h
theorem anchor_primes : ∀ s ∈ FiniteData1024.shifts, (FiniteData1024.target - (FiniteData1024.first + 2 * s)).Prime ∧ FiniteData1024.first + 2 * s ≤ FiniteData1024.target := by
  intro s hs
  simp only [FiniteData1024.shifts, List.mem_cons, List.not_mem_nil, or_false] at hs
  rcases hs with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15 | h16 | h17 | h18 | h19 | h20 | h21 | h22 | h23 | h24 | h25 | h26 | h27 | h28 | h29 | h30 | h31 | h32 | h33 | h34 | h35 | h36 | h37 | h38 | h39 | h40 | h41 | h42 | h43 | h44 | h45 | h46 | h47 | h48 | h49 | h50 | h51 | h52 | h53 | h54 | h55 | h56 | h57 | h58 | h59 | h60 | h61 | h62 | h63 | h64 | h65 | h66 | h67 | h68 | h69 | h70 | h71 | h72 | h73 | h74 | h75 | h76 | h77 | h78 | h79 | h80 | h81 | h82 | h83 | h84 | h85 | h86 | h87 | h88 | h89 | h90 | h91 | h92 | h93 | h94 | h95 | h96 | h97 | h98 | h99 | h100 | h101 | h102 | h103 | h104 | h105 | h106 | h107 | h108 | h109
  · subst s
    exact ⟨prime_3999999988766605309, by decide⟩
  · subst s
    exact ⟨prime_3999999988766605261, by decide⟩
  · subst s
    exact ⟨prime_3999999988766605193, by decide⟩
  · subst s
    exact ⟨prime_3999999988766605099, by decide⟩
  · subst s
    exact ⟨prime_3999999988766605097, by decide⟩
  · subst s
    exact ⟨prime_3999999988766605091, by decide⟩
  · subst s
    exact ⟨prime_3999999988766605027, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604853, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604817, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604803, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604653, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604649, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604619, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604503, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604419, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604373, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604359, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604353, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604307, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604287, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604271, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604259, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604217, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604197, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604191, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604187, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604167, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604139, by decide⟩
  · subst s
    exact ⟨prime_3999999988766604001, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603977, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603929, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603867, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603837, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603819, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603803, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603791, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603777, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603737, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603707, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603699, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603603, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603539, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603501, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603477, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603281, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603273, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603249, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603191, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603189, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603123, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603113, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603099, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603093, by decide⟩
  · subst s
    exact ⟨prime_3999999988766603021, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602963, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602957, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602819, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602657, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602649, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602621, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602571, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602543, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602531, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602517, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602507, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602501, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602489, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602343, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602333, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602307, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602277, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602259, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602243, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602241, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602213, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602169, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602151, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602147, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602081, by decide⟩
  · subst s
    exact ⟨prime_3999999988766602061, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601983, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601947, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601923, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601913, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601901, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601889, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601803, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601731, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601607, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601587, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601527, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601511, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601503, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601487, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601481, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601467, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601353, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601349, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601329, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601319, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601233, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601217, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601181, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601107, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601077, by decide⟩
  · subst s
    exact ⟨prime_3999999988766601041, by decide⟩
  · subst s
    exact ⟨prime_3999999988766600977, by decide⟩
  · subst s
    exact ⟨prime_3999999988766600941, by decide⟩
  · subst s
    exact ⟨prime_3999999988766600881, by decide⟩
  · subst s
    exact ⟨prime_3999999988766600789, by decide⟩
theorem coverage : (shiftedUnion FiniteData1024.source FiniteData1024.shifts &&& (2 ^ 1024 - 1)) = 2 ^ 1024 - 1 := by decide +kernel
theorem binary_index : ∀ j < 1024, BinaryGoldbach (FiniteData1024.target + 2 * j) :=
  binaryGoldbach_of_bitmap FiniteData1024.first FiniteData1024.source FiniteData1024.target 1024 FiniteData1024.shifts source_primes anchor_primes coverage
theorem binary_interval : ∀ n : Nat, 3999999997356537860 ≤ n → n < 3999999997356539908 → n % 2 = 0 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n :=
  binaryGoldbach_interval FiniteData1024.target 1024 (by decide) binary_index
end FiniteP0N1024
