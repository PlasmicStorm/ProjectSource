if(ttl <= 0)
	instance_destroy();
if(animate > 0)
{
	x += x_offset;
	y += sin((ttl - 100) * 0.5) + y_offset;
	animate -= 0.1;
}
alpha = ttl/100;
ttl--;