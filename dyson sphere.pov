#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc" 
#include "textures.inc"
#include "metals.inc"           

#declare LightX = 0;
#declare LightY = 40;
#declare LightZ = -40;
#declare SRadius = 0;
#declare SFalloff = 11; 

#declare espelho = texture {
    T_Silver_3B
}

#declare Camera_1 = camera {angle 45    
                            location  <5, 10,-15>
                            right     x*image_width/image_height
                            look_at  < 0, 0, 0> }
camera{Camera_1}
 
light_source{<1500,2500,-2500> color White*0.10}    


light_source {
    <LightX, LightY, LightZ> color White
    spotlight
    point_at <0, 0, 0>
    tightness 0
    radius SRadius
    falloff SFalloff 
}

light_source {
   <0, 0, 0> color White
   area_light <0, 0, 0>, <0, 0, 0>, 9, 9
   adaptive 1
   jitter
}

#include "stars.inc"
sphere { <0,0,0>, 1  
         texture {Starfield1 scale 0.25} 
         scale 5000
}
                        
#declare Orbita_espelho  = 16;                        
#declare Raio_Sol = 4;

#declare Sol =
 light_source{ <0,0,0> 
              color White
              looks_like{ 
                   sphere{ <0,0,0>,Raio_Sol
                           texture{ 
                            pigment{ gradient y turbulence 2.75
                                     color_map{ 
                                     [0.0 color rgb <1,0.7,0.5>]
                                     [0.3 color rgb <1,1,0.3>]
                                     [0.7 color rgb <1,0.8,0.2>]
                                     [1.0 color rgb <1,0.3,0.5>] } 
                                     scale 1.5
                                    } 
                            normal {agate 2.00
                                     scale 0.5}
                            finish {ambient 0.9   
                                    diffuse 0.1
                                    phong 1}
            } 
        } 
    } 
}

#declare Time =  clock - 0.00 ;  

#declare Sol_rotacao = 12*Time*30;  

object{Sol rotate <0,Sol_rotacao,0>}    

#declare Esfera =
sphere{ <2.5,2.5,2.5>,0.03
        texture{
          espelho
          finish { phong 1
            reflection{0.3 metallic 0.5}}
               } 
}          

union{
 #local Nr =  0;      
 #local End = 6000; 
 #while (Nr < End)  
    object{ Esfera translate <1,0,0>
            rotate<0,0,80+Nr*120/End>
            rotate<0,48*Nr*360/End>  
            rotate <0,Sol_rotacao,0>
          }
 #local Nr = Nr + 1;  
 #end 
}           