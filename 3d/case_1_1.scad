/*
    DM50 - Javier Báscones Velázquez - 2024
    
    https://www.montanacolors.com/en/productos/mtn-pro-plastic-bumper-paint/
    
*/

// Battery
// AA  : 50 x 14.2
// AAA : 44.5x10.5
// AAAA: 42.5x8.3

$fn=32;
key1_rows = 5; //5 (1 for modeling)
key1_cols = 6; //6 (1 for modeling)

tolerance = 0.2; // tolerance margin (mm) 
keys_hspace = 4;
keys_vspace = 5;
r = 0.5; // chamfers

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
junction_l = 3;
junction_r = 0.8;
junction_space = 1;
junction_hover = 1.0;

key_bottom_margin = 0.2;

push_wall = 0.2;
push_size = 4;
push_height = 0.0;
push_hole = 2;
push_r1   = 1;
push_r2   = 0.6;
push_r_h = 1;

wall01 = junction_h;

module insert_hole()
{
    translate([key1_l/2, key1_w/2, 0])
    union()
    {
        translate([-push_size/2, -push_wall/2, -1])
            cube([push_size, push_wall, push_hole+push_height+1]);
        translate([-push_wall/2, -push_size/2, -1])
            cube([push_wall, push_size, push_hole+push_height+1]);
        translate([0, 0, -1])
            cylinder(push_hole+1, push_r1, push_r1);
    }
}


module insert()
{
    translate([key1_l/2, key1_w/2, push_hole])
    union()
    {
        translate([0, 0, -push_hole-push_r_h])
            cylinder(push_r_h, push_r2, push_r1);
        translate([0, 0, -push_hole])
            cylinder(push_hole, push_r1, push_r1);
    }
}


module key01()
{   
    translate([0, 0, -r])
    difference()
    {
        union()
        {
            translate([r, r, r])
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

            translate([key1_l/5 - junction_w / 2, -junction_l, r])
                cube([junction_w, junction_l+key_wall, junction_h]);

            translate([ key1_l/5 * 4 - junction_w / 2, -junction_l, r])
                cube([junction_w, junction_l+key_wall, junction_h]);
            
            // JUNCTION TOP SLICE
            translate([key1_l/2, key1_w + junction_space, r])
            union()
            {
                cylinder(junction_h, junction_r, junction_r);
                translate([-junction_r, -junction_space - junction_r/2 - key_wall/2 - tolerance/2, 0])
                    cube([junction_r * 2, key_wall+junction_space , junction_h]);
            }
        }
        
        translate([-key1_l/2, -key1_w/2, -r])
        cube([key1_l*2, key1_w*2, r*2]);
        
        insert_hole();
    }
}



module key01_diff( x = 0, y = 0 )
{

    union()
    {
        translate([x+r-tolerance, y+r-tolerance - key_bottom_margin, -1])
        minkowski()
        {
          cube([key1_l+tolerance*2-r*2, key1_w+tolerance*2-r*2+key_bottom_margin, key_height-r+2]);
          sphere(r=r);
        }
        
        translate([key1_l/2, key1_w + junction_space, -0.5])
        union()
        {
            cylinder(key_wall+1, junction_r+tolerance, junction_r+tolerance);
            translate([-junction_w, -junction_space - junction_r/2, junction_h-0.5])
                cube([junction_r*2+tolerance*2, junction_space + junction_r/2, junction_h*4]);
        }

        
        translate([key1_l/5, 0, -0.5])
        union()
        {
            translate([-junction_w / 2 - tolerance, -junction_l, junction_h-0.5])
                cube([junction_w+tolerance*2, junction_l+key_wall, junction_h*4]);
        }

        translate([key1_l/5*4, 0, -0.5])
        union()
        {
            translate([ - junction_w / 2 - tolerance, -junction_l, junction_h-0.5])
                cube([junction_w+tolerance*2, junction_l+key_wall, junction_h*4]);
        }
        
    }
}



color([0.2,0.2,0.2])
union()
{
    difference()
    {
        translate([-5, -5, 0]) cube([75, 60, wall01]);
        for ( y = [0 : key1_rows-1] ){
            for ( x = [0 : key1_cols-1] ){
                translate([key1_xspace*x, key1_yspace*y, 0]) key01_diff();
            }
        }
    }
    for ( y = [0 : key1_rows-1] ){
        for ( x = [0 : key1_cols-1] ){
            translate([key1_xspace*x, key1_yspace*y, wall01-junction_h]) key01();
        }
    }
}


//key01_diff();

/*
for ( y = [0 : 3] ){
    for ( x = [0 : 5] ){
        translate([key1_xspace*x, key1_yspace*y, 0]) key01();
    }
}
*/


