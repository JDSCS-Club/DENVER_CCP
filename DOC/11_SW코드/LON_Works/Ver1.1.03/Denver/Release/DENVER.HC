Reading self-doc info...#pragma set_id_string      "Denver"
#pragma set_node_sd_string "COMM, WOOJIN, LIC, 2012-05-17"

#pragma app_buf_out_size           146
#pragma app_buf_out_count          2
#pragma app_buf_out_priority_count 2
#pragma net_buf_out_count          2
#pragma net_buf_out_priority_count 2
#pragma net_buf_in_size            146
#pragma net_buf_in_count           2
#pragma app_buf_in_size            146
#pragma app_buf_in_count           2
#pragma receive_trans_count        11

#pragma num_domain_entries      2
#pragma num_addr_table_entries  10
#pragma num_alias_table_entries 10

network input sd_string("&0,,0\x90,25;") config Non_SNVT nci00NetConfig;  // NV index 0
network input sd_string("@0|1") SNVT_obj_request nvi00ObjRequest;  // NV index 1
network output sd_string("@0|2") SNVT_obj_status nvo00ObjStatus;  // NV index 2
network input sd_string("@0|3") Non_SNVT nvi00CDTCommand;  // NV index 3
network output sd_string("@0|4") bind_info( Rep'td ) SNVT_time_stamp nvo00TimeStamp;  // NV index 4
network input sd_string("@0|5") SNVT_file_req nvi00FileReq;  // NV index 5
network output sd_string("@0|6") SNVT_file_status nvo00FileStat;  // NV index 6
network input sd_string("@1|1") Non_SNVT nvi01Subscribe;  // NV index 7
network output sync sd_string("@1|2") SNVT_165 nvo01StatusBits;  // NV index 8
network output sync sd_string("@1|3") SNVT_165 nvo01StatusBits2;  // NV index 9
network input sd_string("@1|4") bind_info( Unackd ) SNVT_state nvi01TransfState;  // NV index 10
network output sd_string("@1|5") bind_info( Unackd ) Non_SNVT nvo01Parameter;  // NV index 11
network input sync sd_string("@1|6") bind_info( Unackd ) SNVT_165 nvi01CDTStBits;  // NV index 12
network input sd_string("@1|8") bind_info( Unackd ) Non_SNVT nvi01CDTParam;  // NV index 13
network input sd_string("@3|1") Non_SNVT nvi03SCIVersReq;  // NV index 14
network output sd_string("@3|2") Non_SNVT nvo03SCIVersion;  // NV index 15
network input sd_string("@4|1") Non_SNVT nvi04WaysideResp;  // NV index 16
network output sd_string("@4|2") Non_SNVT nvo04WaysideReq;  // NV index 17
/*
-------------------------------------------------------------
Self documentation structure length = 464, version number = 0
Number of declared NVs = 18, total NVs = 18, message tags = 0
-------------------------------------------------------------
*/
