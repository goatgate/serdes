# SerDes
Operating frequency = 50 Mhz

# Overview
The top module implements a Serializer/Deserializer (SERDES) system. It converts 8-bit parallel data into a 10-bit serial format for transmission and then converts it back to the original 8-bit parallel data. This module is particularly useful in high-speed communication applications where minimizing pin count is crucial.

# Block Diagram

+--------------------+
|   8-bit Data In    |
|   (data_8b_in)     |
+--------------------+
           |
           v
+---------------------+
|    latch_8bit       |
+---------------------+
           |
           v
+---------------------+
| encoder_8b_10b      |
+---------------------+
           |
           v
+---------------------+
|    latch_10bit      |
+---------------------+
           |
           v
+---------------------+
|   piso_10bit        | 
+---------------------+
           |
           v
+---------------------+
|    sipo_10bit       |
|     (ser_in)        |
+---------------------+
           |
           v
+---------------------+
|    latch_10bit      |
+---------------------+
           |
           v
+---------------------+
| decoder_10b_8b      |
+---------------------+
           |
           v
+---------------------+
|    latch_8bit      |
+---------------------+
           |
           v
+--------------------+
|   8-bit Data Out   |
|   (data_out)       |
+--------------------+
