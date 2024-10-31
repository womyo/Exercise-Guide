//
//  ResultData.swift
//  ExerciseGuide
//
//  Created by 이인호 on 10/31/24.
//

import Foundation

struct APIResponse: Codable {
    let response: ResponseData
}

struct ResponseData: Codable {
    let header: ResponseHeader
    let body: ResponseBody
}

struct ResponseHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

struct ResponseBody: Codable {
    let pageNo: Int
    let totalCount: Int
    let items: ItemList
    let numOfRows: Int
}

struct ItemList: Codable {
    let item: [Result]
}

struct Result: Codable {
    let trng_mscl_nm: String
    let rptt_tcnt_nm: String
    let file_url: String
    let vdo_desc: String
    let file_sz: Int
    let fps_cnt: Double
    let ftns_lvl_nm: String
    let row_num: Int
    let resolution: String
    let tool_nm: String
    let aggrp_nm: String
    let frme_no: Int
    let ecrg_cycl_nm: String
    let img_file_nm: String
    let trng_mscl_zn_nm: String
    let fbctn_yr: String
    let nope_nm: String
    let trng_plc_nm: String
    let vdo_len: String
    let trng_mscl_part: String
    let lang: String
    let trng_nm: String
    let job_ymd: String
    let ftns_fctr_nm: String
    let trng_mscl_class: String
    let vdo_ttl_nm: String
    let snap_tm: Double
    let trng_hr_nm: String
    let file_type_nm: String
    let file_nm: String
    let trng_mscl_eng_nm: String
    let img_file_url: String
    let img_file_sn: Int
    let data_type: String
    let set_cnt_nm: String
}
