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
        x = float(raw_input ("X value, input a period if you are done"))
        y = float(raw_input ("Y value"))
        if x == "." or y == ".":
            switch = False
        else :
            ans.append((x,y))
    return ans

def write_code (image_width, image_height):
        point_list = make_points()
        new_points = f(point_list, -image_width,-image_height)
        g(new_points)
        
        
