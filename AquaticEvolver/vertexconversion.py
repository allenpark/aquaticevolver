def f (point_list,xoff,yoff):
	ans = []
	xOffset = xoff
	yOffset= yoff
	for point in point_list:
		x = point[0] + xOffset
		y = point[1] + yOffset
		ans.append((x,y))
	return ans


def g (new_points):
	for point in new_points:
		print "new b2Vec2(AEWorld.b2NumFromFlxNum("+str(point[0])+"),AEWorld.b2NumFromFlxNum("+str(point[1])+")),"


def make_points():
    ans = []
    switch = True
    while switch:
        x = (raw_input ("X value, input a period if you are done"))
        y = (raw_input ("Y value"))
        if x == "." or y == ".":
            switch = False
        else :
                x = float(x)
                y= float(y)
                ans.append((x,y))
    return ans

def write_code (image_width, image_height):
        """Use this function, type in the x coordinate, then hit enter, then the y
        coordinate and enter again, when you are done put in one period for the x
        and one period for the y"""

        
        point_list = make_points()
        new_points = f(point_list, -image_width/2.0,-image_height/2.0)
        g(new_points)
        
        
