# SerDes
Operating frequency = 50 Mhz

# Overview
The top module implements a Serializer/Deserializer (SERDES) system. It converts 8-bit parallel data into a 10-bit serial format for transmission and then converts it back to the original 8-bit parallel data. This module is particularly useful in high-speed communication applications where minimizing pin count is crucial.

# Block Diagram

  +--------------------+       +--------------------+
  |                    |       |                    |
  |    Encoder         |       |      Decoder       |
  |                    |       |                    |
  |                    |       |                    |
  |  +--------------+  |       |  +--------------+  |
  |  | 8-bit Input |----->     |  | 10-bit Input |----->  
  |  | (data_8b_in)|       |  |  | (data_10b_in)|       
  |  +--------------+  |       |  +--------------+  |
  |                    |       |                    |
  |   10-bit Output   |<-----|   |   8-bit Output  |
  |  (data_10b_out)   |       |  |  (data_8b_out)  |
  +--------------------+       +--------------------+
