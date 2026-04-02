partition 
{ 
    overlay 
    {
       region {} reset[addr=0];         
       region {} vects[addr=8];         
       region {} code[addr=0x3000];                     
       region {} init;                  
       region {} exit;                  
       CODETOP = $;
       region {} const;                 
       region {} string;                        
       region {} data[roundsize=4];     
       region {} ram[roundsize=4];      
       EEPBOTTOM = $;
       region {} eeprom; /* Size is according to need */
       EEPTOP = $;
       region {} malloc[size=0x1000]; /* 4k. Not used actually */
       STKBOTTOM = $;
       region {} stack[size=0x10000]; /* 64K */
       STKTOP = $;                      
    } ov1; 
} RAM[addr=0x0000]; 

