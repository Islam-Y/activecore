// ===========================================================
// HLS sources generated by ActiveCore framework
// Date: 2021-12-23 02:09:23
// Copyright Alexander Antonov <antonov.alex.alex@gmail.com>
// ===========================================================

#ifndef __genexu_FP_FMA_h_
#define __genexu_FP_FMA_h_

#include <ap_int.h>

#ifndef __genstructdel_req_struct_
#define __genstructdel_req_struct_
typedef struct {
	ap_uint<32> trx_id;
	ap_uint<32> opcode;
	ap_uint<32> src0_data;
	ap_uint<32> src1_data;
	ap_uint<32> src2_data;
	ap_uint<1> rd0_req;
	ap_uint<32> rd0_tag;
} req_struct;
#endif // __genstructdel_req_struct_

#ifndef __genstructdel_resp_struct_
#define __genstructdel_resp_struct_
typedef struct {
	ap_uint<32> trx_id;
	ap_uint<1> rd0_req;
	ap_uint<32> rd0_tag;
	ap_uint<32> rd0_wdata;
} resp_struct;
#endif // __genstructdel_resp_struct_

#endif