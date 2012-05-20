-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                               Wave_Io.ads                                 --
--                                                                           --
--                                 SPEC                                      --
--                                                                           --
--                   Copyright (C) 1996 Ulrik Hørlyk Hjort                   --
--                                                                           --
--  Sound Syntese is free software;  you can  redistribute it                --
--  and/or modify it under terms of the  GNU General Public License          --
--  as published  by the Free Software  Foundation;  either version 2,       --
--  or (at your option) any later version.                                   --
--  Sound Syntese is distributed in the hope that it will be                 --
--  useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty    --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  --
--  See the GNU General Public License for  more details.                    --
--  You should have  received  a copy of the GNU General                     --
--  Public License  distributed with Yolk.  If not, write  to  the  Free     --
--  Software Foundation,  51  Franklin  Street,  Fifth  Floor, Boston,       --
--  MA 02110 - 1301, USA.                                                    --
--                                                                           --
-------------------------------------------------------------------------------
with Interfaces; use Interfaces;

package Wave_Io is

   subtype Data_Type is Short_Integer;
   type Dynamic_Wave_Data_Buffer is array (Natural range <>) of Data_Type;
   type Dynamic_Wave_Data_Buffer_Access is access Dynamic_Wave_Data_Buffer;

   type Wave_Header_Type is
      record
         RIFF_Chunck   : String(1..4); -- "RIFF"
         Chunk_Size    : Unsigned_32;
         WAVE_Format   : String(1..4); -- "WAVE"
         Subchunk1_ID  : String(1..4); -- "fmt "
         Subchunk1Size : Unsigned_32;
         AudioFormat   : Unsigned_16;  -- PCM = 1 (i.e. Linear quantization, No Compression)
         NumChannels   : Unsigned_16;  -- Mono = 1, Stereo = 2, etc.
         SampleRate    : Unsigned_32;  -- 8000, 44100, etc.
         ByteRate      : Unsigned_32;  -- SampleRate * NumChannels * BitsPerSample/8
         BlockAlign    : Unsigned_16;  -- NumChannels * BitsPerSample/8
         BitsPerSample : Unsigned_16;  -- 8 Bits = 8, 16 Bits = 16, Etc.
         Subchunk2ID   : String(1..4); --  "data"
         Subchunk2Size : Unsigned_32;  --  This is The Number of Bytes in The Data = NumSamples * NumChannels * BitsPerSample/8
      end record;


   type Wave_File_T is
      record
         Header : Wave_Header_Type;
         Data   : Dynamic_Wave_Data_Buffer_Access;
      end record;

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure DeAllocate(Wave_File : in out Wave_File_T);

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Allocate_Data_Buffer(Wave_File : out Wave_File_T);

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Init_Header(Wave_File : out Wave_File_T);

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Update_Header(Wave_File : in out Wave_File_T;
                           Sample_Rate : Unsigned_32;
                           Channel_Numbers : Unsigned_16;
                           Data_Length : Unsigned_32);
   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Wave_Info(Wave_File : in Wave_File_T);

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Load(File_Name : in String; Wave_File : in out Wave_File_T);

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Save(File_Name : in String; Wave_File : in Wave_File_T);


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Dump_Wave_Data(Wave_File : in Wave_File_T);


   procedure Test;
end Wave_Io;
