SupportAxisHeight           = 140                        ;
SupportWidth                = 200                       ;
AxisRadius                  = 5.5                       ;


AxisSupportThickness        = 8                        ;
AxisSupportWidth            = 8                         ;

cubeSupportLenght           = 80                        ;
cubeSupportScrewPartLength  = 20                        ;
ScrewRadius                 = 2                         ;

A                           = acos(SupportAxisHeight/sqrt((SupportWidth/2)*(SupportWidth/2)+SupportAxisHeight*SupportAxisHeight))   ;
Hypotenuse                  = SupportAxisHeight/cos(A)                                                                              ;
T                           = AxisSupportThickness                                                                                  ;
O                           = ((T/(2*cos(90-A)))-(T/2))*sin(A)                                                                      ;
D                           = (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(A)-O                                    ;
H                           = D/cos(A)                                                                                              ;
L                           = D*tan(A)                                                                                              ;

NodeLenght                  = 15    ;

LengthStrengh               = L*2;
TranslateXStrengh           = D * cos(90 - A);
TranslateYStrengh           = D * cos(A);

FootHeight                  = 15;

A2                          = atan((SupportAxisHeight-D-NodeLenght+AxisSupportThickness/2)/(SupportWidth/2));
BoltThickness               = 100;                        ;
ConnectionLength            = BoltThickness/2+cubeSupportScrewPartLength/2  ;

// $fn                     = 300   ;
// echo("ConnectionLength",ConnectionLength);

module Base1()
{
    difference()
    {
        // axis support fixation structure 1
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(-A)-AxisSupportThickness/2*sin(A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(-A)-AxisSupportThickness/2*cos(A) , 0])
        {
            rotate([0 , 0 , -A])
            {
               cube([ Hypotenuse-cubeSupportLenght+cubeSupportScrewPartLength-AxisRadius+10*AxisSupportThickness*cos(A), AxisSupportThickness , AxisSupportWidth]);
            }
        }
        // screw part removal
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(-A)-AxisSupportThickness/2*sin(A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(-A)-AxisSupportThickness/2*cos(A), -0.5])   // Screw fixation hole part 1
        {
            rotate([0 , 0 , -A])
            {
                cube([cubeSupportScrewPartLength , AxisSupportThickness/2 , AxisSupportWidth+10]);
            }
        }
        //screw holes
        translate([(cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*cos(-A) , (cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*sin(-A), AxisSupportWidth/2])  // screw hole 1 support 1
        {
            rotate([90 , 0 , -A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([(cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*cos(-A) , (cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*sin(-A), AxisSupportWidth/2])  // screw hole 2 support 1
        {
            rotate([90 , 0 , -A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        // plane foot removal
        translate([SupportAxisHeight , -SupportWidth*2 , -0.5])
        {
            cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
        }
    }
    difference()
    {
        // horizontal base part
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), 0]) // horizontal strength structure between axis support
        {
            cube([ AxisSupportThickness , (SupportAxisHeight-FootHeight)*tan(A)+cubeSupportScrewPartLength/2-AxisSupportThickness/2/cos(A), AxisSupportWidth]);
        }
        // screw part removal
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , 0 , AxisSupportWidth/2]) // screw part
        {
            cube([ AxisSupportThickness , cubeSupportScrewPartLength, AxisSupportWidth+1] , center = true);
        }
        //screw holes
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])  // screw hole 2 support 1
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , 1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])  // screw hole 2 support 1
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
    }
    //oblic strenght structure
    difference()
    {
        translate([Hypotenuse*cos(-A)-AxisSupportThickness/2*sin(A) , Hypotenuse*sin(-A)-AxisSupportThickness/2*cos(A), ])
        {
            rotate([0 , 0 , A2])
            {
                cube([ AxisSupportThickness , (AxisSupportThickness/2 + SupportWidth/2)/cos(A2), AxisSupportWidth]);
            }
        }
        // plane foot removal
        translate([SupportAxisHeight , -SupportWidth*2 , -0.5])
        {
            cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
        }
        // screw hole
        translate([D+NodeLenght-AxisSupportThickness/2 , 0 , 0])
        {
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        //assembly thickness removal
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2 , AxisSupportWidth*2/3-AxisSupportWidth])
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
            }
        }
        //removal of the conflicting part with the second base
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2+AxisSupportThickness , 0])
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
            }
        }
        //removal of the conflicting part with axis structure
        translate([AxisSupportThickness/2+0.5  ,-(AxisSupportThickness*10)/2 , -0.5])
        {
            {
                cube([D , AxisSupportThickness*10 , AxisSupportWidth+1]);
            }
        }
    }
    
    difference()
    {
        //assembly part to connect 2 strutures
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), 0]) // horizontal strength structure between axis support
        {
            // color("red")cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
            cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength]) // horizontal strength structure between axis support
        {
            cube([ AxisSupportThickness , AxisSupportWidth/2 , cubeSupportScrewPartLength]);
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-3/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
        {
            rotate([90 , 0 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-1/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
        {
            rotate([90 , 0 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
    }
}
    
    
    
    
    

module Base2()
{
    difference()
    {
        // axis support fixation structure 1
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(A)-AxisSupportThickness/2*sin(-A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(A)-AxisSupportThickness/2*cos(-A) , 0])
        {
            rotate([0 , 0 , A])
            {
               cube([ Hypotenuse-cubeSupportLenght+cubeSupportScrewPartLength-AxisRadius+10*AxisSupportThickness*cos(A), AxisSupportThickness , AxisSupportWidth]);
            }
        }
        // screw part removal
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(A), -0.5])
        {
            rotate([0 , 0 , A])
            {
                cube([cubeSupportScrewPartLength , AxisSupportThickness/2 , AxisSupportWidth+1]);
            }
        }
        //screw holes
        translate([(cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*sin(A), AxisSupportWidth/2])
        {
            rotate([90 , 0 , A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([(cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*sin(A), AxisSupportWidth/2])
        {
            rotate([90 , 0 , A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        // plane foot removal
        translate([SupportAxisHeight , 0 , -0.5])
        {
            cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
        }
    }
    difference()
    {
        // horizontal base part
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -cubeSupportScrewPartLength/2, 0])
        {
            cube([ AxisSupportThickness , (SupportAxisHeight-FootHeight)*tan(A)+cubeSupportScrewPartLength/2-AxisSupportThickness/2/cos(A), AxisSupportWidth]);
        }
        // screw part removal
        translate([SupportAxisHeight-FootHeight , 0 , AxisSupportWidth/2])
        {
            cube([ AxisSupportThickness , cubeSupportScrewPartLength, AxisSupportWidth+1] , center = true);
        }
        //screw holes
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , 1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
    }
    
    difference()
    {
        mirror([0 , 1 , 0])
        {
            difference()
            {
                //oblic strenght structure//removal of the conflicting part with axis structure
                translate([Hypotenuse*cos(-A)-AxisSupportThickness/2*sin(A) , Hypotenuse*sin(-A)-AxisSupportThickness/2*cos(A), ])
                {
                    rotate([0 , 0 , A2])
                    {
                        cube([ AxisSupportThickness , (AxisSupportThickness/2 + SupportWidth/2)/cos(A2), AxisSupportWidth]);
                    }
                }
                // plane foot removal
                translate([SupportAxisHeight , -SupportWidth*2 , -0.5])
                {
                    cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
                }
                //assembly thickness removal
                translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2 , AxisSupportWidth*1/3])
                {
                    {
                        cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
                    }
                }    
            }
        }
        // screw hole
        translate([D+NodeLenght-AxisSupportThickness/2 , 0 , 0])
        {
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        //removal of the conflicting part with the first base
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2-AxisSupportThickness-10 , -0.5])
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
            }
        }
        //removal of the conflicting part with axis structure
        translate([AxisSupportThickness/2+0.5 ,-(AxisSupportThickness*10)/2 , -0.5])
        {
            {
                cube([D , AxisSupportThickness*10 , AxisSupportWidth+1]);
            }
        }   
    }
    mirror([0 , 1 , 0])
    {

        difference()
        {
            //assembly part to connect 2 strutures
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), 0]) // horizontal strength structure between axis support
            {
                // color("red")cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
                cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
            }
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength]) // horizontal strength structure between axis support
            {
                cube([ AxisSupportThickness , AxisSupportWidth/2 , cubeSupportScrewPartLength]);
            }
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-3/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-1/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
        }
    }
}

    
module Base3()
{
    difference()
    {
        // axis support fixation structure 1
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(-A)-AxisSupportThickness/2*sin(A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(-A)-AxisSupportThickness/2*cos(A) , 0])
        {
            rotate([0 , 0 , -A])
            {
               cube([ Hypotenuse-cubeSupportLenght+cubeSupportScrewPartLength-AxisRadius+10*AxisSupportThickness*cos(A), AxisSupportThickness , AxisSupportWidth]);
            }
        }
        // screw part removal
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(-A)-AxisSupportThickness/2*sin(A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(-A)-AxisSupportThickness/2*cos(A), -0.5])   // Screw fixation hole part 1
        {
            rotate([0 , 0 , -A])
            {
                cube([cubeSupportScrewPartLength , AxisSupportThickness/2 , AxisSupportWidth+10]);
            }
        }
        //screw holes
        translate([(cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*cos(-A) , (cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*sin(-A), AxisSupportWidth/2])  // screw hole 1 support 1
        {
            rotate([90 , 0 , -A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([(cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*cos(-A) , (cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*sin(-A), AxisSupportWidth/2])  // screw hole 2 support 1
        {
            rotate([90 , 0 , -A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        // plane foot removal
        translate([SupportAxisHeight , -SupportWidth*2 , -0.5])
        {
            cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
        }
    }
    difference()
    {
        // horizontal base part
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), 0]) // horizontal strength structure between axis support
        {
            cube([ AxisSupportThickness , (SupportAxisHeight-FootHeight)*tan(A)+cubeSupportScrewPartLength/2-AxisSupportThickness/2/cos(A), AxisSupportWidth]);
        }
        // screw part removal
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , 0 , AxisSupportWidth/2]) // screw part
        {
            cube([ AxisSupportThickness , cubeSupportScrewPartLength, AxisSupportWidth+1] , center = true);
        }
        //screw holes
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])  // screw hole 2 support 1
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , 1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])  // screw hole 2 support 1
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
    }
    //oblic strenght structure
    difference()
    {
        translate([Hypotenuse*cos(-A)-AxisSupportThickness/2*sin(A) , Hypotenuse*sin(-A)-AxisSupportThickness/2*cos(A), ])
        {
            rotate([0 , 0 , A2])
            {
                cube([ AxisSupportThickness , (AxisSupportThickness/2 + SupportWidth/2)/cos(A2), AxisSupportWidth]);
            }
        }
        // plane foot removal
        translate([SupportAxisHeight , -SupportWidth*2 , -0.5])
        {
            cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
        }
        // screw hole
        translate([D+NodeLenght-AxisSupportThickness/2 , 0 , 0])
        {
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        //assembly thickness removal
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2 , AxisSupportWidth*2/3-AxisSupportWidth])
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
            }
        }
        //removal of the conflicting part with the second base
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2+AxisSupportThickness , 0])
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
            }
        }
        //removal of the conflicting part with axis structure
        translate([AxisSupportThickness/2+0.5  ,-(AxisSupportThickness*10)/2 , -0.5])
        {
            {
                cube([D , AxisSupportThickness*10 , AxisSupportWidth+1]);
            }
        }
    }
    
    difference()
    {
        //assembly part to connect 2 strutures
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), 0]) // horizontal strength structure between axis support
        {
            cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A)+AxisSupportWidth/2, ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength]) // horizontal strength structure between axis support
        {
            cube([ AxisSupportThickness , AxisSupportWidth/2 , cubeSupportScrewPartLength]);
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-3/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
        {
            rotate([90 , 0 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-1/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
        {
            rotate([90 , 0 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
    }
}
    
    
    
    
module Base4()
{
    difference()
    {
        // axis support fixation structure 1
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(A)-AxisSupportThickness/2*sin(-A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(A)-AxisSupportThickness/2*cos(-A) , 0])
        {
            rotate([0 , 0 , A])
            {
               cube([ Hypotenuse-cubeSupportLenght+cubeSupportScrewPartLength-AxisRadius+10*AxisSupportThickness*cos(A), AxisSupportThickness , AxisSupportWidth]);
            }
        }
        // screw part removal
        translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)*sin(A), -0.5])
        {
            rotate([0 , 0 , A])
            {
                cube([cubeSupportScrewPartLength , AxisSupportThickness/2 , AxisSupportWidth+1]);
            }
        }
        //screw holes
        translate([(cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*sin(A), AxisSupportWidth/2])
        {
            rotate([90 , 0 , A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([(cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*sin(A), AxisSupportWidth/2])
        {
            rotate([90 , 0 , A])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        // plane foot removal
        translate([SupportAxisHeight , 0 , -0.5])
        {
            cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
        }
    }
    difference()
    {
        // horizontal base part
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -cubeSupportScrewPartLength/2, 0])
        {
            cube([ AxisSupportThickness , (SupportAxisHeight-FootHeight)*tan(A)+cubeSupportScrewPartLength/2-AxisSupportThickness/2/cos(A), AxisSupportWidth]);
        }
        // screw part removal
        translate([SupportAxisHeight-FootHeight , 0 , AxisSupportWidth/2])
        {
            cube([ AxisSupportThickness , cubeSupportScrewPartLength, AxisSupportWidth+1] , center = true);
        }
        //screw holes
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , 1/4*cubeSupportScrewPartLength, AxisSupportWidth/2])
        {
            rotate([0 , 90 , 0])
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
    }
    
    difference()
    {
        mirror([0 , 1 , 0])
        {
            difference()
            {
                //oblic strenght structure//removal of the conflicting part with axis structure
                translate([Hypotenuse*cos(-A)-AxisSupportThickness/2*sin(A) , Hypotenuse*sin(-A)-AxisSupportThickness/2*cos(A), ])
                {
                    rotate([0 , 0 , A2])
                    {
                        cube([ AxisSupportThickness , (AxisSupportThickness/2 + SupportWidth/2)/cos(A2), AxisSupportWidth]);
                    }
                }
                // plane foot removal
                translate([SupportAxisHeight , -SupportWidth*2 , -0.5])
                {
                    cube([ SupportAxisHeight , SupportWidth*2, AxisSupportWidth+1]);
                }
                //assembly thickness removal
                translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2 , AxisSupportWidth*1/3])
                {
                    {
                        cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
                    }
                }    
            }
        }
        // screw hole
        translate([D+NodeLenght-AxisSupportThickness/2 , 0 , 0])
        {
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        //removal of the conflicting part with the first base
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2-AxisSupportThickness-10 , -0.5])
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+10 , AxisSupportWidth]);
            }
        }
        //removal of the conflicting part with axis structure
        translate([AxisSupportThickness/2+0.5 ,-(AxisSupportThickness*10)/2 , -0.5])
        {
            {
                cube([D , AxisSupportThickness*10 , AxisSupportWidth+1]);
            }
        }   
    }
    mirror([0 , 1 , 0])
    {

        difference()
        {
            //assembly part to connect 2 strutures
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), 0]) // horizontal strength structure between axis support
            {
                // color("red")cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
                cube([ AxisSupportThickness , AxisSupportWidth ,ConnectionLength+AxisSupportWidth]);
            }
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A)+AxisSupportWidth/2, ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength]) // horizontal strength structure between axis support
            {
                cube([ AxisSupportThickness , AxisSupportWidth/2 , cubeSupportScrewPartLength]);
            }
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-3/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
            translate([SupportAxisHeight-FootHeight-AxisSupportThickness/2 , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A), ConnectionLength+AxisSupportWidth-1/4*cubeSupportScrewPartLength]) // horizontal strength structure between axis support
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
        }
    }
}

    
    
    
    
    
    
    
module ThreeBoltSupportConnection()
{
    rotate([0 , -90 , 0])
    {
        difference()
        {
            cube([ AxisSupportThickness , AxisSupportWidth , cubeSupportScrewPartLength+BoltThickness]);
            
            translate([0 , AxisSupportWidth/2, BoltThickness])
            {
                cube([ AxisSupportThickness , AxisSupportWidth/2 , cubeSupportScrewPartLength]);
            }
            cube([ AxisSupportThickness , AxisSupportWidth/2 , cubeSupportScrewPartLength]);
            
            translate([AxisSupportThickness/2 , 0 , 1/4*cubeSupportScrewPartLength])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
            translate([AxisSupportThickness/2 , 0 , 3/4*cubeSupportScrewPartLength])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
            
            translate([AxisSupportThickness/2 , 0 , BoltThickness+1/4*cubeSupportScrewPartLength])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
            translate([AxisSupportThickness/2 , 0 , BoltThickness+3/4*cubeSupportScrewPartLength])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                }
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    
module AxisSupport()
{
    difference()    // axis support
    {
        union()
        {
            cylinder(h = AxisSupportWidth , r = AxisSupportThickness+AxisRadius);
            difference()
            {
                // axis support fixation structure 2
                rotate([0 , 0 , -A])   
                {
                    translate([0 , -AxisSupportThickness/2 , 0])
                    {
                        cube([ cubeSupportLenght+AxisRadius, AxisSupportThickness , AxisSupportWidth]);
                    }
                    
                }
                // screw holes
                translate([(cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*cos(-A) , (cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*sin(-A), AxisSupportWidth/2])  // screw hole 1 support 1
                {
                    rotate([90 , 0 , -A])
                    {
                        cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                    }
                }
                translate([(cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*cos(-A) , (cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*sin(-A), AxisSupportWidth/2])  // screw hole 2 support 1
                {
                    rotate([90 , 0 , -A])
                    {
                        cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                    }
                }
            }
            difference()
            {
                // axis support fixation structure 2
                rotate([0 , 0 , A])
                {

                    translate([0 , -AxisSupportThickness/2 , 0])
                    {
                        cube([ cubeSupportLenght+AxisRadius , AxisSupportThickness , AxisSupportWidth]);
                    }
                }
                // screw holes
                translate([(cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-3/4*cubeSupportScrewPartLength)*sin(A), AxisSupportWidth/2])  // screw hole 1 support 1
                {
                    rotate([90 , 0 , A])
                    {
                        cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                    }
                }
                translate([(cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*cos(A) , (cubeSupportLenght+AxisRadius-1/4*cubeSupportScrewPartLength)*sin(A), AxisSupportWidth/2])  // screw hole 2 support 1
                {
                    rotate([90 , 0 , A])
                    {
                        cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
                    }
                }
            }
            // horizontal strength structure between axis support
            translate([D , 0 , AxisSupportWidth/2]) 
            {
                {
                    cube([ AxisSupportThickness, LengthStrengh , AxisSupportWidth] , center = true);
                }
            }
            // vertical strength structure between axis support
            translate([0 , AxisSupportThickness/2 , 0])
            {
                rotate([0 , 0 , -90])
                {
                    cube([ AxisSupportThickness, D+NodeLenght , AxisSupportWidth]);
                }
            }
            // oblic strength structure between axis support 1
            translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)/2*cos(-A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)/2*sin(-A) , 0])
            {
                rotate([0 , 0 , A])
                {
                    cube([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)/2 , AxisSupportThickness , AxisSupportWidth]);
                }
            }
            // oblic strength structure between axis support 1
            mirror([0,1,0])
            {
                translate([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)/2*cos(-A) , (cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)/2*sin(-A) , 0])
                {
                    rotate([0 , 0 , A])
                    {
                        cube([(cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength)/2 , AxisSupportThickness , AxisSupportWidth]);
                    }
                }
            }
        }
        // Axis Hole
        translate([0 , 0 , -0.5])   
        {
            cylinder(h = AxisSupportWidth+1 , r = AxisRadius);
        }
        // Screw fixation hole part 1
        rotate([0 , 0 , -A])
        {
            translate([cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength , 0 , -0.5])
            {
                cube([cubeSupportScrewPartLength , AxisSupportThickness/2 , AxisSupportWidth+1]);
            }
        }
        // Screw fixation hole part 2
        rotate([0 , 0 , A])
        {
            translate([cubeSupportLenght+AxisRadius-cubeSupportScrewPartLength , -AxisSupportThickness/2 , -0.5])
            {
                cube([cubeSupportScrewPartLength , AxisSupportThickness/2 , AxisSupportWidth+1]);
            }
        }
        //screw hole for oblic base structure assembly
        translate([D+NodeLenght-AxisSupportThickness/2 , 0 , 0])
        {
            {
                cylinder(h = AxisSupportThickness+50 , r = ScrewRadius , center = true);
            }
        }
        //thickness assembly removals
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2-0.5 , AxisSupportWidth*2/3])   // Axis Hole
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+1 , AxisSupportWidth]);
            }
        }
        translate([D+AxisSupportThickness/2 , -AxisSupportThickness/2-0.5 , -AxisSupportWidth+AxisSupportWidth*1/3])   // Axis Hole
        {
            {
                cube([NodeLenght+1 , AxisSupportThickness+1 , AxisSupportWidth]);
            }
        }
    }
}

module AssembledView()
{
    translate([0 , 0 , BoltThickness*2+2*AxisSupportWidth+2 ])
    {   
        rotate([180 , 0 , 0])
        {   
            color("DarkOrchid")AxisSupport();
        }
    }

    translate([0 , 0 , BoltThickness*2+2*AxisSupportWidth+2 ])
    {   
        rotate([180 , 0 , 0])
        {   
            color("MediumPurple")Base1();
        }
    }

    translate([0 , 0 , BoltThickness*2+2*AxisSupportWidth+2])
    {   
        rotate([180 , 0 , 0])
        {   
            color("MediumSlateBlue")Base2();
        }
    }

    translate([0 , 0 , 0 ])
    {   
        color("MediumSpringGreen")AxisSupport();
    }

    translate([0 , 0 , 0 ])
    {   
        color("PaleGreen")Base3();
    }

    translate([0 , 0 , 0 ])
    {   
        color("DarkCyan")Base4();
    }

    translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A) , ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength+1])
    {
        rotate([0 , 90 , 0])
        {
            color("Crimson")ThreeBoltSupportConnection();
        }
    }
    mirror([0 , 1 , 0])
    {
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A) , ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength+1])
        {
            rotate([0 , 90 , 0])
            {
                color("Salmon")ThreeBoltSupportConnection();
            }
        }
    }
}


module SplitView()
{
    translate([-50 , 25 , BoltThickness*2+2*AxisSupportWidth+2+2*cubeSupportScrewPartLength ])
    {   
        rotate([180 , 0 , 0])
        {   
            AxisSupport();
        }
    }

    translate([0 , 50 , BoltThickness*2+2*AxisSupportWidth+2+2*cubeSupportScrewPartLength ])
    {   
        rotate([180 , 0 , 0])
        {   
            Base1();
        }
    }

    translate([0 , 0 , BoltThickness*2+2*AxisSupportWidth+2+2*cubeSupportScrewPartLength ])
    {   
        rotate([180 , 0 , 0])
        {   
            Base2();
        }
    }

    translate([-50 , 25 , 0 ])
    {   
        AxisSupport();
    }

    Base3();

    translate([0 , 50 , 0 ])
    {   
        Base4();
    }

    translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A) , ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength+1+cubeSupportScrewPartLength])
    {
        rotate([0 , 90 , 0])
        {
            ThreeBoltSupportConnection();
        }
    }
    mirror([0 , 1 , 0])
    {
        translate([SupportAxisHeight-FootHeight-AxisSupportThickness , -((SupportAxisHeight-FootHeight)*tan(A))+AxisSupportThickness/2/cos(A)-50 , ConnectionLength+AxisSupportWidth-cubeSupportScrewPartLength+1+cubeSupportScrewPartLength ])
        {
            rotate([0 , 90 , 0])
            {
                ThreeBoltSupportConnection();
            }
        }
    }
}

module PlaneView()
{
    translate([-SupportAxisHeight/2 , 0 , 0 ])
    {
        AxisSupport();
    }
    translate([-SupportAxisHeight/2-D , -SupportWidth/2 , 0 ])
    {
        Base1();
    }
    translate([-SupportAxisHeight/2-D , SupportWidth/2 , 0 ])
    {
        Base2();
    }
    
    translate([SupportAxisHeight/2 , 0 , 0 ])
    {
        AxisSupport();
    }
    translate([SupportAxisHeight/2-D , -SupportWidth/2 , 0 ])
    {
        Base3();
    }
    translate([SupportAxisHeight/2-D , SupportWidth/2 , 0 ])
    {
        Base4();
    }
    
    translate([100 , SupportWidth/3 , 0 ])
    {
        ThreeBoltSupportConnection();
    }
    translate([100 , -SupportWidth/3 , 0 ])
    {
        ThreeBoltSupportConnection();
    }
}

module PrintView()
{
    // AxisSupport();
    // Base1();
    // Base2();
    // Base3();
    // Base4();
    ThreeBoltSupportConnection();
}




// AssembledView();
// SplitView();
// PlaneView();
PrintView();
