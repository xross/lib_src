// Copyright 2016-2021 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.
// Downsample by factor of 3 example
// Uses Signed 32b Integer format

// Include files
#include <stdio.h>
#include <xs1.h>
#include <stdint.h>
#include "src.h"

#define NUM_CHANNELS  2
#define NUM_OUTPUT_SAMPLES  256

// 0db 1KHz 48KHz sinewave - pure tone test
const int32_t s1k_0db_48[1024] = {0, 277499757, 550251420, 813588109, 1063004099, 1294231806, 1503314879, 1686675721, 1841177179, 1964175542, 2053566235, 2107819915, 2126008198, 2107819915, 2053566235, 1964175414, 1841177051, 1686675593, 1503314751, 1294231678, 1063003971, 813587981, 550251228, 277499565, -185, -277499949, -550251612, -813588301, -1063004291, -1294231934, -1503315007, -1686675849, -1841177179, -1964175542, -2053566235, -2107819915, -2126008198, -2107819915, -2053566107, -1964175286, -1841176923, -1686675465, -1503314623, -1294231550, -1063003779, -813587789, -550251036, -277499405, 371, 277500141, 550251804, 813588493, 1063004419, 1294232062, 1503315135, 1686675977, 1841177307, 1964175670, 2053566363, 2107819915, 2126008198, 2107819787, 2053566107, 1964175286, 1841176923, 1686675337, 1503314495, 1294231422, 1063003651, 813587597, 550250908, 277499213, -557, -277500301, -550251996, -813588621, -1063004611, -1294232318, -1503315263, -1686676105, -1841177435, -1964175670, -2053566363, -2107820043, -2126008198, -2107819787, -2053566107, -1964175158, -1841176795, -1686675337, -1503314367, -1294231166, -1063003459, -813587469, -550250716, -277499021, 743, 277500493, 550252124, 813588813, 1063004739, 1294232446, 1503315391, 1686676233, 1841177563, 1964175798, 2053566491, 2107820043, 2126008198, 2107819787, 2053565979, 1964175158, 1841176667, 1686675209, 1503314239, 1294231038, 1063003331, 813587277, 550250524, 277498829, -929, -277500685, -550252316, -813589005, -1063004931, -1294232574, -1503315519, -1686676361, -1841177563, -1964175798, -2053566491, -2107820043, -2126008198, -2107819787, -2053565979, -1964175030, -1841176539, -1686675081, -1503314111, -1294230910, -1063003139, -813587085, -550250332, -277498669, 1115, 277500877, 550252508, 813589197, 1063005123, 1294232702, 1503315647, 1686676361, 1841177691, 1964175926, 2053566491, 2107820043, 2126008198, 2107819787, 2053565851, 1964175030, 1841176539, 1686674953, 1503313983, 1294230782, 1063003011, 813586957, 550250140, 277498477, -1301, -277501037, -550252700, -813589325, -1063005251, -1294232830, -1503315775, -1686676489, -1841177819, -1964175926, -2053566619, -2107820043, -2126008198, -2107819659, -2053565851, -1964174902, -1841176411, -1686674825, -1503313855, -1294230654, -1063002819, -813586765, -550250012, -277498285, 1486, 277501229, 550252892, 813589517, 1063005443, 1294232958, 1503315903, 1686676617, 1841177819, 1964176054, 2053566619, 2107820171, 2126008198, 2107819659, 2053565851, 1964174902, 1841176283, 1686674697, 1503313727, 1294230526, 1063002691, 813586573, 550249820, 277498093, -1672, -277501421, -550253020, -813589709, -1063005571, -1294233086, -1503316031, -1686676745, -1841177947, -1964176182, -2053566619, -2107820171, -2126008198, -2107819659, -2053565723, -1964174774, -1841176155, -1686674569, -1503313471, -1294230398, -1063002499, -813586445, -550249628, -277497933, 1858, 277501613, 550253212, 813589837, 1063005763, 1294233342, 1503316159, 1686676873, 1841178075, 1964176182, 2053566747, 2107820171, 2126008198, 2107819659, 2053565723, 1964174646, 1841176155, 1686674441, 1503313343, 1294230142, 1063002371, 813586253, 550249436, 277497741, -2044, -277501805, -550253404, -813590029, -1063005891, -1294233470, -1503316287, -1686677001, -1841178203, -1964176310, -2053566747, -2107820171, -2126008198, -2107819659, -2053565723, -1964174646, -1841176027, -1686674441, -1503313215, -1294230014, -1063002179, -813586061, -550249244, -277497549, 2230, 277501965, 550253596, 813590221, 1063006083, 1294233598, 1503316415, 1686677129, 1841178203, 1964176310, 2053566875, 2107820171, 2126008198, 2107819659, 2053565595, 1964174518, 1841175899, 1686674313, 1503313087, 1294229886, 1063002051, 813585933, 550249116, 277497357, -2416, -277502157, -550253788, -813590349, -1063006211, -1294233726, -1503316543, -1686677257, -1841178331, -1964176438, -2053566875, -2107820171, -2126008198, -2107819531, -2053565595, -1964174518, -1841175899, -1686674185, -1503312959, -1294229758, -1063001859, -813585741, -550248924, -277497197, 2602, 277502349, 550253916, 813590541, 1063006403, 1294233854, 1503316671, 1686677385, 1841178459, 1964176438, 2053566875, 2107820299, 2126008198, 2107819531, 2053565467, 1964174390, 1841175771, 1686674057, 1503312831, 1294229630, 1063001731, 813585549, 550248732, 277497005, -2787, -277502541, -550254108, -813590733, -1063006531, -1294233982, -1503316799, -1686677385, -1841178587, -1964176566, -2053567003, -2107820299, -2126008198, -2107819531, -2053565467, -1964174390, -1841175643, -1686673929, -1503312703, -1294229502, -1063001539, -813585357, -550248540, -277496813, 2973, 277502701, 550254300, 813590861, 1063006723, 1294234238, 1503316927, 1686677513, 1841178587, 1964176566, 2053567003, 2107820299, 2126008198, 2107819531, 2053565467, 1964174262, 1841175515, 1686673801, 1503312575, 1294229374, 1063001411, 813585229, 550248348, 277496621, -3159, -277502893, -550254492, -813591053, -1063006851, -1294234366, -1503317055, -1686677641, -1841178715, -1964176694, -2053567003, -2107820299, -2126008198, -2107819531, -2053565339, -1964174262, -1841175515, -1686673673, -1503312447, -1294229118, -1063001219, -813585037, -550248220, -277496461, 3345, 277503085, 550254684, 813591245, 1063007043, 1294234494, 1503317183, 1686677769, 1841178843, 1964176822, 2053567131, 2107820299, 2126008198, 2107819403, 2053565339, 1964174134, 1841175387, 1686673545, 1503312319, 1294228990, 1063001091, 813584845, 550248028, 277496269, -3531, -277503277, -550254812, -813591373, -1063007171, -1294234622, -1503317311, -1686677897, -1841178843, -1964176822, -2053567131, -2107820427, -2126008198, -2107819403, -2053565339, -1964174006, -1841175259, -1686673417, -1503312191, -1294228862, -1063000899, -813584717, -550247836, -277496077, 3717, 277503437, 550255004, 813591565, 1063007363, 1294234750, 1503317439, 1686678025, 1841178971, 1964176950, 2053567259, 2107820427, 2126008198, 2107819403, 2053565211, 1964174006, 1841175131, 1686673417, 1503312063, 1294228734, 1063000771, 813584525, 550247644, 277495885, -3903, -277503629, -550255196, -813591757, -1063007491, -1294234878, -1503317567, -1686678153, -1841179099, -1964176950, -2053567259, -2107820427, -2126008198, -2107819403, -2053565211, -1964173878, -1841175131, -1686673289, -1503311935, -1294228606, -1063000579, -813584333, -550247452, -277495693, 4088, 277503821, 550255388, 813591885, 1063007683, 1294235006, 1503317695, 1686678281, 1841179227, 1964177078, 2053567259, 2107820427, 2126008198, 2107819403, 2053565083, 1964173878, 1841175003, 1686673161, 1503311807, 1294228478, 1063000451, 813584205, 550247324, 277495533, -4274, -277504013, -550255580, -813592077, -1063007811, -1294235262, -1503317823, -1686678281, -1841179227, -1964177078, -2053567387, -2107820427, -2126008198, -2107819275, -2053565083, -1964173750, -1841174875, -1686673033, -1503311679, -1294228222, -1063000259, -813584013, -550247132, -277495341, 4460, 277504173, 550255708, 813592269, 1063008003, 1294235390, 1503317951, 1686678409, 1841179355, 1964177206, 2053567387, 2107820555, 2126008198, 2107819275, 2053565083, 1964173750, 1841174875, 1686672905, 1503311551, 1294228094, 1063000131, 813583821, 550246940, 277495149, -4646, -277504365, -550255900, -813592397, -1063008131, -1294235518, -1503318079, -1686678537, -1841179483, -1964177206, -2053567387, -2107820555, -2126008198, -2107819275, -2053564955, -1964173622, -1841174747, -1686672777, -1503311423, -1294227966, -1062999939, -813583693, -550246748, -277494957, 4832, 277504557, 550256092, 813592589, 1063008323, 1294235646, 1503318207, 1686678665, 1841179611, 1964177334, 2053567515, 2107820555, 2126008198, 2107819275, 2053564955, 1964173622, 1841174619, 1686672649, 1503311295, 1294227838, 1062999811, 813583501, 550246556, 277494797, -5018, -277504749, -550256284, -813592781, -1063008451, -1294235774, -1503318335, -1686678793, -1841179611, -1964177462, -2053567515, -2107820555, -2126008198, -2107819275, -2053564955, -1964173494, -1841174491, -1686672521, -1503311167, -1294227710, -1062999619, -813583309, -550246428, -277494605, 5204, 277504909, 550256476, 813592973, 1063008643, 1294235902, 1503318463, 1686678921, 1841179739, 1964177462, 2053567643, 2107820555, 2126008198, 2107819147, 2053564827, 1964173366, 1841174491, 1686672521, 1503311039, 1294227582, 1062999427, 813583181, 550246236, 277494413, -5389, -277505101, -550256604, -813593101, -1063008771, -1294236158, -1503318719, -1686679049, -1841179867, -1964177590, -2053567643, -2107820555, -2126008198, -2107819147, -2053564827, -1964173366, -1841174363, -1686672393, -1503310911, -1294227454, -1062999299, -813582989, -550246044, -277494221, 5575, 277505293, 550256796, 813593293, 1063008963, 1294236286, 1503318847, 1686679177, 1841179867, 1964177590, 2053567643, 2107820683, 2126008198, 2107819147, 2053564699, 1964173238, 1841174235, 1686672265, 1503310783, 1294227198, 1062999107, 813582797, 550245852, 277494061, -5761, -277505485, -550256988, -813593485, -1063009091, -1294236414, -1503318975, -1686679305, -1841179995, -1964177718, -2053567771, -2107820683, -2126008198, -2107819147, -2053564699, -1964173238, -1841174107, -1686672137, -1503310655, -1294227070, -1062998979, -813582669, -550245660, -277493869, 5947, 277505645, 550257180, 813593613, 1063009283, 1294236542, 1503319103, 1686679305, 1841180123, 1964177718, 2053567771, 2107820683, 2126008198, 2107819147, 2053564699, 1964173110, 1841174107, 1686672009, 1503310527, 1294226942, 1062998787, 813582477, 550245532, 277493677, -6133, -277505837, -550257372, -813593805, -1063009411, -1294236670, -1503319231, -1686679433, -1841180251, -1964177846, -2053567771, -2107820683, -2126008198, -2107819147, -2053564571, -1964173110, -1841173979, -1686671881, -1503310399, -1294226814, -1062998659, -813582285, -550245340, -277493485, 6319, 277506029, 550257500, 813593997, 1063009603, 1294236798, 1503319359, 1686679561, 1841180251, 1964177846, 2053567899, 2107820683, 2126008198, 2107819019, 2053564571, 1964172982, 1841173851, 1686671753, 1503310271, 1294226686, 1062998467, 813582157, 550245148, 277493325, -6505, -277506221, -550257692, -813594125, -1063009731, -1294236926, -1503319487, -1686679689, -1841180379, -1964177974, -2053567899, -2107820811, -2126008198, -2107819019, -2053564571, -1964172982, -1841173851, -1686671625, -1503310143, -1294226558, -1062998339, -813581965, -550244956, -277493133, 6691, 277506381, 550257884, 813594317, 1063009923, 1294237182, 1503319615, 1686679817, 1841180507, 1964178102, 2053568027, 2107820811, 2126008198, 2107819019, 2053564443, 1964172854, 1841173723, 1686671497, 1503310015, 1294226302, 1062998147, 813581773, 550244764, 277492941, -6876, -277506573, -550258076, -813594509, -1063010051, -1294237310, -1503319743, -1686679945, -1841180635, -1964178102, -2053568027, -2107820811, -2126008198, -2107819019, -2053564443, -1964172726, -1841173595, -1686671497, -1503309887, -1294226174, -1062998019, -813581581, -550244636, -277492749, 7062, 277506765, 550258268, 813594637, 1063010243, 1294237438, 1503319871, 1686680073, 1841180635, 1964178230, 2053568027, 2107820811, 2126008198, 2107819019, 2053564315, 1964172726, 1841173467, 1686671369, 1503309759, 1294226046, 1062997827, 813581453, 550244444, 277492589, -7248, -277506957, -550258460, -813594829, -1063010435, -1294237566, -1503319999, -1686680201, -1841180763, -1964178230, -2053568155, -2107820811, -2126008198, -2107818891, -2053564315, -1964172598, -1841173467, -1686671241, -1503309631, -1294225918, -1062997699, -813581261, -550244252, -277492397, 7434, 277507149, 550258588, 813595021, 1063010563, 1294237694, 1503320127, 1686680201, 1841180891, 1964178358, 2053568155, 2107820939, 2126008198, 2107818891, 2053564315, 1964172598, 1841173339, 1686671113, 1503309503};
// -6db 4/5KHz 48KHz sinewaves - intermodulation test
const int32_t im4k5k_m6dB_48[1024] = {0, 1190523165, 1967042101, 2065749272, 1466758218, 396719369, -759249949, -1601426338, -1859774933, -1484644677, -651982717, 314985730, 1073741631, 1388727394, 1207792408, 662838586, -45, -527684994, -759250333, -677022646, -393017066, -81733807, 107267448, 116782205, 674, -116781093, -107266968, 81733575, 393016170, 677021430, 759249181, 527684258, -40, -662838010, -1207791512, -1388726370, -1073740928, -314985410, 651982525, 1484644165, 1859774293, 1601425826, 759249629, -396719401, -1466758090, -2065749144, -1967041845, -1190523037, 153, 1190523293, 1967042229, 2065749528, 1466758346, 396719305, -759250269, -1601426978, -1859775573, -1484645189, -651982909, 314986018, 1073742399, 1388728418, 1207793432, 662839162, -130, -527685730, -759251485, -677023862, -393017962, -81734031, 107267984, 116783325, 2022, -116779981, -107266432, 81733351, 393015242, 677020150, 759247965, 527683522, -125, -662837498, -1207790488, -1388725474, -1073740160, -314985154, 651982333, 1484643525, 1859773653, 1601425186, 759249309, -396719465, -1466757962, -2065748888, -1967041589, -1190522781, 307, 1190523549, 1967042485, 2065749784, 1466758474, 396719241, -759250589, -1601427490, -1859776341, -1484645829, -651983101, 314986274, 1073743167, 1388729442, 1207794328, 662839674, -151, -527686466, -759252701, -677025078, -393018794, -81734263, 107268520, 116784437, 3370, -116778805, -107265896, 81733119, 393014346, 677018934, 759246813, 527682818, -210, -662836922, -1207789592, -1388724450, -1073739456, -314984866, 651982141, 1484643013, 1859773013, 1601424674, 759248925, -396719497, -1466757706, -2065748632, -1967041461, -1190522653, 460, 1190523677, 1967042741, 2065750040, 1466758602, 396719177, -759250909, -1601428002, -1859776981, -1484646341, -651983293, 314986594, 1073743935, 1388730466, 1207795352, 662840250, -237, -527687170, -759253853, -677026422, -393019690, -81734487, 107269064, 116785581, 4718, -116777685, -107265352, 81732887, 393013450, 677017654, 759245661, 527682082, -296, -662836410, -1207788696, -1388723426, -1073738688, -314984610, 651981949, 1484642501, 1859772245, 1601424034, 759248605, -396719625, -1466757578, -2065748376, -1967041205, -1190522397, 614, 1190523933, 1967042997, 2065750168, 1466758730, 396719145, -759251229, -1601428642, -1859777621, -1484646853, -651983549, 314986882, 1073744703, 1388731490, 1207796248, 662840826, -322, -527687906, -759255005, -677027638, -393020586, -81734719, 107269600, 116786693, 6067, -116776573, -107264816, 81732663, 393012554, 677016438, 759244445, 527681378, -381, -662835834, -1207787672, -1388722402, -1073737920, -314984322, 651981693, 1484641989, 1859771605, 1601423522, 759248285, -396719657, -1466757450, -2065748120, -1967040949, -1190522269, 768, 1190524061, 1967043253, 2065750424, 1466758858, 396719049, -759251613, -1601429154, -1859778389, -1484647493, -651983741, 314987138, 1073745471, 1388732514, 1207797144, 662841338, -407, -527688642, -759256221, -677028854, -393021514, -81734951, 107270136, 116787805, 7415, -116775461, -107264280, 81732431, 393011722, 677015158, 759243293, 527680642, -466, -662835258, -1207786776, -1388721378, -1073737216, -314983970, 651981501, 1484641349, 1859770965, 1601422882, 759247965, -396719721, -1466757322, -2065747992, -1967040693, -1190522141, 921, 1190524189, 1967043381, 2065750680, 1466759114, 396719017, -759251933, -1601429794, -1859779029, -1484648005, -651983933, 314987458, 1073746239, 1388733538, 1207798168, 662841914, -493, -527689378, -759257373, -677030070, -393022410, -81735175, 107270680, 116788957, 8763, -116774349, -107263736, 81732207, 393010826, 677013942, 759242141, 527679874, -488, -662834746, -1207785752, -1388720354, -1073736448, -314983714, 651981309, 1484640837, 1859770197, 1601422370, 759247645, -396719753, -1466757194, -2065747736, -1967040565, -1190521885, 1075, 1190524445, 1967043637, 2065750936, 1466759242, 396718953, -759252253, -1601430306, -1859779669, -1484648517, -651984125, 314987746, 1073747007, 1388734562, 1207799064, 662842426, -578, -527690082, -759258525, -677031350, -393023306, -81735407, 107271152, 116790069, 10111, -116773229, -107263200, 81731975, 393009898, 677012662, 759240925, 527679170, -573, -662834170, -1207784856, -1388719330, -1073735680, -314983426, 651981117, 1484640325, 1859769557, 1601421730, 759247325, -396719817, -1466757066, -2065747480, -1967040309, -1190521757, 1229, 1190524573, 1967043765, 2065751192, 1466759370, 396718889, -759252573, -1601430946, -1859780309, -1484649157, -651984317, 314988002, 1073747647, 1388735586, 1207800088, 662843002, -663, -527690850, -759259741, -677032566, -393024202, -81735631, 107271688, 116791181, 11460, -116772053, -107262728, 81731751, 393009002, 677011446, 759239773, 527678434, -658, -662833594, -1207783832, -1388718306, -1073734912, -314983138, 651980925, 1484639685, 1859768917, 1601421218, 759247005, -396719849, -1466756938, -2065747224, -1967040053, -1190521629, 1382, 1190524829, 1967044021, 2065751320, 1466759498, 396718825, -759252893, -1601431458, -1859781077, -1484649669, -651984509, 314988322, 1073748415, 1388736610, 1207800984, 662843578, -685, -527691554, -759260893, -677033782, -393025098, -81735863, 107272232, 116792325, 12808, -116770941, -107262184, 81731519, 393008106, 677010230, 759238621, 527677730, -744, -662833082, -1207782936, -1388717282, -1073734208, -314982882, 651980733, 1484639173, 1859768277, 1601420578, 759246685, -396719977, -1466756682, -2065746968, -1967039925, -1190521373, 1536, 1190524957, 1967044277, 2065751576, 1466759626, 396718793, -759253213, -1601432098, -1859781717, -1484650181, -651984701, 314988578, 1073749183, 1388737506, 1207802008, 662844090, -770, -527692258, -759262045, -677035062, -393025930, -81736087, 107272768, 116793445, 14156, -116769829, -107261648, 81731287, 393007210, 677008950, 759237405, 527676994, -829, -662832506, -1207781912, -1388716258, -1073733440, -314982594, 651980541, 1484638661, 1859767509, 1601420066, 759246301, -396720009, -1466756554, -2065746840, -1967039669, -1190521245, 1690, 1190525085, 1967044533, 2065751832, 1466759754, 396718697, -759253533, -1601432610, -1859782357, -1484650821, -651984957, 314988866, 1073749951, 1388738658, 1207802904, 662844666, -855, -527693026, -759263261, -677036342, -393026858, -81736319, 107273304, 116794557, 15504, -116768709, -107261112, 81731063, 393006314, 677007734, 759236253, 527676290, -915, -662831994, -1207781016, -1388715234, -1073732672, -314982242, 651980285, 1484638021, 1859766869, 1601419426, 759245981, -396720073, -1466756426, -2065746584, -1967039413, -1190521117, 1843, 1190525213, 1967044789, 2065752088, 1466759882, 396718665, -759253853, -1601433122, -1859783125, -1484651333, -651985149, 314989186, 1073750719, 1388739682, 1207803800, 662845242, -941, -527693730, -759264413, -677037558, -393027754, -81736551, 107273848, 116795701, 16853, -116767597, -107260568, 81730831, 393005418, 677006454, 759235101, 527675490, -1000, -662831418, -1207780120, -1388714210, -1073731904, -314981986, 651980093, 1484637509, 1859766229, 1601418914, 759245661, -396720105, -1466756298, -2065746328, -1967039157, -1190520861, 1997, 1190525469, 1967044917, 2065752344, 1466760010, 396718601, -759254237, -1601433762, -1859783765, -1484651845, -651985341, 314989442, 1073751487, 1388740578, 1207804824, 662845754, -1026, -527694466, -759265565, -677038774, -393028650, -81736775, 107274384, 116796813, 18201, -116766485, -107260032, 81730607, 393004554, 677005238, 759233885, 527674786, -1021, -662830842, -1207779096, -1388713186, -1073731200, -314981698, 651979901, 1484636997, 1859765461, 1601418274, 759245341, -396720169, -1466756170, -2065746072, -1967038901, -1190520733, 2151, 1190525597, 1967045173, 2065752472, 1466760138, 396718537, -759254557, -1601434402, -1859784405, -1484652357, -651985533, 314989730, 1073752255, 1388741602, 1207805720, 662846330, -1111, -527695202, -759266781, -677039990, -393029546, -81737007, 107274920, 116797933, 19549, -116765309, -107259496, 81730375, 393003658, 677003958, 759232733, 527674050, -1107, -662830330, -1207778200, -1388712290, -1073730432, -314981442, 651979709, 1484636357, 1859764821, 1601417762, 759245021, -396720201, -1466756042, -2065745944, -1967038773, -1190520477, 2304, 1190525853, 1967045429, 2065752728, 1466760266, 396718473, -759254877, -1601434914, -1859785045, -1484652997, -651985725, 314990050, 1073752895, 1388742626, 1207806744, 662846842, -1197, -527695938, -759267933, -677041270, -393030442, -81737231, 107275400, 116799077, 20898, -116764197, -107259016, 81730151, 393002762, 677002742, 759231581, 527673346, -1192, -662829754, -1207777176, -1388711138, -1073729664, -314981154, 651979517, 1484635845, 1859764181, 1601417122, 759244701, -396720329, -1466755914, -2065745688, -1967038517, -1190520349, 2458, 1190525981, 1967045557, 2065752984, 1466760394, 396718441, -759255197, -1601435426, -1859785685, -1484653509, -651985917, 314990306, 1073753663, 1388743650, 1207807640, 662847418, -1282, -527696642, -759269085, -677042550, -393031338, -81737463, 107275936, 116800189, 22246, -116763077, -107258480, 81729919, 393001866, 677001526, 759230365, 527672642, -1277, -662829242, -1207776280, -1388710242, -1073728896, -314980866, 651979325, 1484635333, 1859763541, 1601416610, 759244381, -396720361, -1466755786, -2065745432, -1967038389, -1190520221, 2612, 1190526109, 1967045813, 2065753240, 1466760650, 396718345, -759255517, -1601436066, -1859786453, -1484654021, -651986109, 314990594, 1073754431, 1388744674, 1207808664, 662847994, -1304, -527697378, -759270301, -677043766, -393032202, -81737687, 107276472, 116801301, 23594, -116761965, -107257944, 81729687, 393000970, 677000246, 759229213, 527671906, -1363, -662828666, -1207775256, -1388709218, -1073728192, -314980546, 651979133, 1484634821, 1859762901, 1601415970, 759243997, -396720425, -1466755658, -2065745176, -1967038133, -1190519965, 2765, 1190526365, 1967046069, 2065753368, 1466760778, 396718313, -759255837, -1601436578, -1859787093, -1484654661, -651986301, 314990882, 1073755199, 1388745698, 1207809560, 662848506, -1389, -527698114, -759271453, -677044982, -393033098, -81737919, 107277016, 116802445, 24942, -116760853, -107257408, 81729463, 393000074, 676999030, 759228061, 527671202, -1448, -662828090, -1207774360, -1388708194, -1073727424, -314980258, 651978941, 1484634181, 1859762133, 1601415458, 759243677, -396720457, -1466755530, -2065744920, -1967037877, -1190519837, 2919, 1190526493, 1967046325, 2065753624, 1466760906, 396718249, -759256157, -1601437218, -1859787733, -1484655173, -651986557, 314991170, 1073755967, 1388746722, 1207810456, 662849082, -1474, -527698818, -759272605, -677046262, -393033994, -81738151, 107277552, 116803565, 26291, -116759741, -107256864, 81729231, 392999146, 676997814, 759226845, 527670402, -1533, -662827578, -1207773464, -1388707170, -1073726656, -314979970, 651978685, 1484633669, 1859761493, 1601414818, 759243357, -396720521, -1466755402, -2065744792, -1967037621, -1190519581, 3073, 1190526621, 1967046453, 2065753880, 1466761034, 396718185, -759256541, -1601437858, -1859788501, -1484655685, -651986749, 314991458, 1073756735, 1388747746, 1207811480, 662849658, -1560, -527699586, -759273821, -677047478, -393034890, -81738375, 107278088, 116804677, 27639, -116758557, -107256328, 81729007, 392998314, 676996534, 759225693, 527669698, -1619, -662827002, -1207772440, -1388706146, -1073725952, -314979714, 651978493, 1484633157, 1859760853, 1601414306, 759243037, -396720553, -1466755146, -2065744536, -1967037365, -1190519453, 3226, 1190526877, 1967046709, 2065754136, 1466761162, 396718121, -759256861, -1601438370, -1859789141, -1484656325, -651986941, 314991714, 1073757503, 1388748770, 1207812376};

int main(void)
{
    unsafe {
        src_ff3_return_code_t return_code = SRC_FF3_NO_ERROR;

        // Input data for both channels
        const int32_t * unsafe input_data[NUM_CHANNELS] = {s1k_0db_48, im4k5k_m6dB_48};

        // Output samples
        int32_t output_data[NUM_CHANNELS];

        // DS3 instances variables
        // -----------------------
        // State and Control structures (one for each channel)
        int                 src_ds3_delay[NUM_CHANNELS][SRC_FF3_DS3_N_COEFS<<1];
        src_ds3_ctrl_t      src_ds3_ctrl[NUM_CHANNELS];

        //Init DS3
        for (int i=0; i<NUM_CHANNELS; i++) {

            printf("Init ds3 channel %d\n", i);
            // Process init
            // ------------
            // Set delay line base to ctrl structure
            src_ds3_ctrl[i].delay_base = src_ds3_delay[i];

            // Init instance
            if (src_ds3_init(&src_ds3_ctrl[i]) != SRC_FF3_NO_ERROR) {
                printf("Error on init\n");
                return_code = SRC_FF3_ERROR;
            }

            // Sync (i.e. clear data)
            // ----
            if (src_ds3_sync(&src_ds3_ctrl[i]) != SRC_FF3_NO_ERROR) {
                printf("Error on sync\n");
                return_code = SRC_FF3_ERROR;
            }

        }

        for (int s=0; s<NUM_OUTPUT_SAMPLES; s++) {
            for (int i=0; i<NUM_CHANNELS; i++) {
                // Set input and output data pointers for the DS3
                src_ds3_ctrl[i].in_data            = (int *)input_data[i];
                src_ds3_ctrl[i].out_data           = (int *)&output_data[i];

                // Do the sample rate conversion on three input samples
                if (src_ds3_proc(&src_ds3_ctrl[i]) != SRC_FF3_NO_ERROR) {
                    printf("Error on ds3 process\n");
                    return_code = SRC_FF3_ERROR;
                }
                //for(int j=0; j<3; j++) printf("in = %d\n", *(input_data[i] + j));
                input_data[i] += 3; // Move input pointer on by 3
                printf("%d\n", output_data[i]);
            }
        }
        return (int)return_code;
    }
}
