/*
    DM50 - Javier Báscones Velázquez - 2024
    
    https://www.montanacolors.com/en/productos/mtn-pro-plastic-bumper-paint/
    
*/

// Battery
// AA  : 50 x 14.2
// AAA : 44.5x10.5
// AAAA: 42.5x8.3

$fn=64;
tolerance = 0.5; // tolerance margin (mm) 
keys_hspace = 4;
keys_vspace = 5;
r = 1; // chamfers

key_wall = 1;
key_height = 2+2+2;
key1_l = 10;
key1_w = 6;
key1_xspace = 11.5;
key1_yspace = 11;

key2_l = 8.5;
key2_w = 6;

pcb_height = 148;
pcb_width = 70;

junction_w = 1.0;
junction_h = 0.5;
junction_l = 2;


module key01( x = 0, y = 0 )
{   
    union()
    {
        translate([x + r, y + r, 0])
        difference()
        { 
            minkowski()
            {
              difference() {
              cube([key1_l-r*2, key1_w-r*2, key_height-r]);
                
              translate([-key1_l/2, -key1_w/2, key_height-2.5])
                rotate(a=[10,0,0])
                    cube([key1_l*2, key1_w*2, key_height-r]);
              }
                
              sphere(r=r);
            }

            translate([-1, -1, -1])
                cube([key1_l+2, key1_w+2, r]);

            translate([ key_wall, key_wall, -key_wall-1])
            minkowski()
            {
              cube([key1_l-r*2-key_wall*2, key1_w-r*2-key_wall*2, key_height-r]);  
              sphere(r=r);
            }            

        }
            
        translate([key1_l/4 - junction_w / 2, -key1_w / 2 + junction_l / 2, 0])
            cube([junction_w, junction_l, junction_h]);
        
        translate([ key1_l/4 * 3 - junction_w / 2, -key1_w / 2 + junction_l / 2, 0])
            cube([junction_w, junction_l, junction_h]);
    }
}

key01();

/*
for ( y = [1 : 4] ){
    for ( x = [1 : 6] ){
        translate([key1_xspace*x, key1_yspace*y, 0]) key01();
    }
}
*/
