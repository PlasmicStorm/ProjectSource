///@param item_id
var sprite_value = -1;
switch(argument0)
{
	case 0:
		sprite_value = spr_book;
		break;
	case 1:
		sprite_value = spr_eye;
		break;
	case 2:
		sprite_value = spr_life_bug;
		break;
	default:
		sprite_value = spr_book;
		break;
}
return sprite_value;