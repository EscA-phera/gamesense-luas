-- Copyright (c) 2019 Localplayer
-- See the file LICENSE for copying permission.
-- Priortize targets v1.0
-- Prioritize a player with a specific flag

--region gs_api
--region Client
local client = {
	latency = client.latency,
	log = client.log,
	userid_to_entindex = client.userid_to_entindex,
	set_event_callback = client.set_event_callback,
	screen_size = client.screen_size,
	eye_position = client.eye_position,
	color_log = client.color_log,
	delay_call = client.delay_call,
	visible = client.visible,
	exec = client.exec,
	trace_line = client.trace_line,
	draw_hitboxes = client.draw_hitboxes,
	camera_angles = client.camera_angles,
	draw_debug_text = client.draw_debug_text,
	random_int = client.random_int,
	random_float = client.random_float,
	trace_bullet = client.trace_bullet,
	scale_damage = client.scale_damage,
	timestamp = client.timestamp,
	set_clantag = client.set_clantag,
	system_time = client.system_time,
	reload_active_scripts = client.reload_active_scripts
}
--endregion

--region Entity
local entity = {
	get_local_player = entity.get_local_player,
	is_enemy = entity.is_enemy,
	hitbox_position = entity.hitbox_position,
	get_player_name = entity.get_player_name,
	get_steam64 = entity.get_steam64,
	get_bounding_box = entity.get_bounding_box,
	get_all = entity.get_all,
	set_prop = entity.set_prop,
	is_alive = entity.is_alive,
	get_player_weapon = entity.get_player_weapon,
	get_prop = entity.get_prop,
	get_players = entity.get_players,
	get_classname = entity.get_classname,
	get_game_rules = entity.get_game_rules,
	get_player_resource = entity.get_prop,
	is_dormant = entity.is_dormant,
}
--endregion

--region Globals
local globals = {
	realtime = globals.realtime,
	absoluteframetime = globals.absoluteframetime,
	tickcount = globals.tickcount,
	curtime = globals.curtime,
	mapname = globals.mapname,
	tickinterval = globals.tickinterval,
	framecount = globals.framecount,
	frametime = globals.frametime,
	maxplayers = globals.maxplayers,
	lastoutgoingcommand = globals.lastoutgoingcommand,
}
--endregion

--region Ui
local ui = {
	new_slider = ui.new_slider,
	new_combobox = ui.new_combobox,
	reference = ui.reference,
	set_visible = ui.set_visible,
	is_menu_open = ui.is_menu_open,
	new_color_picker = ui.new_color_picker,
	set_callback = ui.set_callback,
	set = ui.set,
	new_checkbox = ui.new_checkbox,
	new_hotkey = ui.new_hotkey,
	new_button = ui.new_button,
	new_multiselect = ui.new_multiselect,
	get = ui.get,
	new_textbox = ui.new_textbox,
	mouse_position = ui.mouse_position
}
--endregion

--region Renderer
local renderer = {
	text = renderer.text,
	measure_text = renderer.measure_text,
	rectangle = renderer.rectangle,
	line = renderer.line,
	gradient = renderer.gradient,
	circle = renderer.circle,
	circle_outline = renderer.circle_outline,
	triangle = renderer.triangle,
	world_to_screen = renderer.world_to_screen,
	indicator = renderer.indicator,
	texture = renderer.texture,
	load_svg = renderer.load_svg
}
--endregion
--endregion
--region dependency: vectors_and_angles_1_1_0
--region math
function math.round(number, precision)
	local mult = 10 ^ (precision or 0)
	return math.floor(number * mult + 0.5) / mult
end
--endregion

--region angle
local angle_mt = {}
angle_mt.__index = angle_mt

--- Create a new vector object.
local function angle(p, y, r)
	p = type(p) == "number" and math.min(90, math.max(-90, p)) or 0
	y = type(y) == "number" and math.min(180, math.max(-180, y)) or 0
	r = type(r) == "number" and math.min(180, math.max(-180, r)) or 0

	return setmetatable(
		{
			p = p,
			y = y,
			r = r
		},
		angle_mt
	)
end

--- Clone the angle object.
function angle_mt:clone()
	return angle(self.p, self.y, self.r)
end

--- Unpack the angle.
function angle_mt:unpack()
	return self.p, self.y, self.r
end

--- Set the angle's euler angles to 0.
function angle_mt:nullify()
	self.p = 0
	self.y = 0
	self.r = 0
end

--- Clamps the angle's angles to whole numbers. Equivalent to "angle:round" with no precision.
function angle_mt:round_zero()
	self.p = math.floor(self.p + 0.5)
	self.y = math.floor(self.y + 0.5)
	self.r = math.floor(self.r + 0.5)
end

--- Round the angle's angles.
function angle_mt:round(precision)
	self.p = math.round(self.p, precision)
	self.y = math.round(self.y, precision)
	self.r = math.round(self.r, precision)
end

--- Clamps the angle's angles to the nearest base.
function angle_mt:round_base(base)
	self.p = base * math.round(self.p / base)
	self.y = base * math.round(self.y / base)
	self.r = base * math.round(self.r / base)
end

--- Clamps the angle's angles to whole numbers. Equivalent to "angle:round" with no precision.
function angle_mt:rounded_zero()
	return angle(
		math.floor(self.p + 0.5),
		math.floor(self.y + 0.5),
		math.floor(self.r + 0.5)
	)
end

--- Round the angle's angles.
function angle_mt:rounded(precision)
	return angle(
		math.round(self.p, precision),
		math.round(self.y, precision),
		math.round(self.r, precision)
	)
end

--- Clamps the angle's angles to the nearest base.
function angle_mt:rounded_base(base)
	return angle(
		base * math.round(self.p / base),
		base * math.round(self.y / base),
		base * math.round(self.r / base)
	)
end

--- Returns a string representation of the angle.
function angle_mt.__tostring(operand_a)
	return string.format("%s, %s, %s", operand_a.p, operand_a.y, operand_a.r)
end

--- Concatenates the angle in a string.
function angle_mt.__concat(operand_a)
	return string.format("%s, %s, %s", operand_a.p, operand_a.y, operand_a.r)
end

--- Returns true if the angle is equal to another angle.
function angle_mt.__eq(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return (operand_a == operand_b.p) and (operand_a == operand_b.y) and (operand_a == operand_b.r)
	end

	if (type(operand_b) == "number") then
		return (operand_a.p == operand_b) and (operand_a.y == operand_b) and (operand_a.r == operand_b)
	end

	return (operand_a.p == operand_b.p) and (operand_a.y == operand_b.y) and (operand_a.r == operand_b.r)
end

--- Returns true if the angle is less than another angle.
function angle_mt.__lt(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return (operand_a < operand_b.p) and (operand_a < operand_b.y) and (operand_a < operand_b.r)
	end

	if (type(operand_b) == "number") then
		return (operand_a.p < operand_b) and (operand_a.y < operand_b) and (operand_a.r < operand_b)
	end

	return (operand_a.p < operand_b.p) and (operand_a.y < operand_b.y) and (operand_a.r < operand_b.r)
end

--- Returns true if the angle is less than or equal to another angle.
function angle_mt.__le(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return (operand_a <= operand_b.p) and (operand_a <= operand_b.y) and (operand_a <= operand_b.r)
	end

	if (type(operand_b) == "number") then
		return (operand_a.p <= operand_b) and (operand_a.y <= operand_b) and (operand_a.r <= operand_b)
	end

	return (operand_a.p <= operand_b.p) and (operand_a.y <= operand_b.y) and (operand_a.r <= operand_b.r)
end

--- Adds the angle to another angle.
function angle_mt.__add(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a + operand_b.p,
			operand_a + operand_b.y,
			operand_a + operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p + operand_b,
			operand_a.y + operand_b,
			operand_a.r + operand_b
		)
	end

	return angle(
		operand_a.p + operand_b.p,
		operand_a.y + operand_b.y,
		operand_a.r + operand_b.r
	)
end

--- Subtracts the angle from another angle.
function angle_mt.__sub(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a - operand_b.p,
			operand_a - operand_b.y,
			operand_a - operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p - operand_b,
			operand_a.y - operand_b,
			operand_a.r - operand_b
		)
	end

	return angle(
		operand_a.p - operand_b.p,
		operand_a.y - operand_b.y,
		operand_a.r - operand_b.r
	)
end

--- Multiplies the angle with another angle.
function angle_mt.__mul(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a * operand_b.p,
			operand_a * operand_b.y,
			operand_a * operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p * operand_b,
			operand_a.y * operand_b,
			operand_a.r * operand_b
		)
	end

	return angle(
		operand_a.p * operand_b.p,
		operand_a.y * operand_b.y,
		operand_a.r * operand_b.r
	)
end

--- Divides the angle by the another angle.
function angle_mt.__div(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a / operand_b.p,
			operand_a / operand_b.y,
			operand_a / operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p / operand_b,
			operand_a.y / operand_b,
			operand_a.r / operand_b
		)
	end

	return angle(
		operand_a.p / operand_b.p,
		operand_a.y / operand_b.y,
		operand_a.r / operand_b.r
	)
end

--- Raises the angle to the power of an another angle.
function angle_mt.__pow(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			math.pow(operand_a, operand_b.p),
			math.pow(operand_a, operand_b.y),
			math.pow(operand_a, operand_b.r)
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			math.pow(operand_a.p, operand_b),
			math.pow(operand_a.y, operand_b),
			math.pow(operand_a.r, operand_b)
		)
	end

	return angle(
		math.pow(operand_a.p, operand_b.p),
		math.pow(operand_a.y, operand_b.y),
		math.pow(operand_a.r, operand_b.r)
	)
end

--- Performs modulo on the angle with another angle.
function angle_mt.__mod(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a % operand_b.p,
			operand_a % operand_b.y,
			operand_a % operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p % operand_b,
			operand_a.y % operand_b,
			operand_a.r % operand_b
		)
	end

	return angle(
		operand_a.p % operand_b.p,
		operand_a.y % operand_b.y,
		operand_a.r % operand_b.r
	)
end

--- Performs a unary minus on the angle.
function angle_mt.__unm()
	self.p = -self.p
	self.y = -self.y
	self.r = -self.r
end
--endregion

--region vector
local vector_mt = {}
vector_mt.__index = vector_mt

--- Create a new vector object.
local function vector(x, y, z)
	x = type(x) == "number" and x or 0
	y = type(y) == "number" and y or 0
	z = type(z) == "number" and z or 0

	return setmetatable(
		{
			x = x,
			y = y,
			z = z
		},
		vector_mt
	)
end

--- Returns the bounding box of an entity or nil.
local function vector_bounding_box(eid)
	local x1, y1, x2, y2, a = entity.get_bounding_box(eid)

	if (a == 0) then
		return nil
	end

	return {
		left = x1,
		top = y1,
		right = x2,
		bottom = y2,
		alpha = a
	}
end

--- Returns the hitbox position or nil.
local function vector_hitbox_position(eid, hitbox)
	local x, y, z = entity.hitbox_position(eid, hitbox)

	if (x == nil or y == nil or z == nil) then
		return nil
	end

	return vector(x, y, z)
end

--- Clone the vector object.
function vector_mt:clone()
	return vector(self.x, self.y, self.z)
end

--- Unpack the vector.
function vector_mt:unpack()
	return self.x, self.y, self.z
end

--- Set the vector's coordinates to 0.
function vector_mt:nullify()
	self.x = 0
	self.y = 0
	self.z = 0
end

--- Returns a string representation of the vector.
function vector_mt.__tostring(operand_a)
	return string.format("%s, %s, %s", operand_a.x, operand_a.y, operand_a.z)
end

--- Concatenates the vector in a string.
function vector_mt.__concat(operand_a)
	return string.format("%s, %s, %s", operand_a.x, operand_a.y, operand_a.z)
end


--- Returns true if the vector's coordinates are equal to another vector.
function vector_mt.__eq(operand_a, operand_b)
	return (operand_a.x == operand_b.x) and (operand_a.y == operand_b.y) and (operand_a.z == operand_b.z)
end

--- Returns true if the vector is less than another vector.
function vector_mt.__lt(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return (operand_a < operand_b.x) and (operand_a < operand_b.y) and (operand_a < operand_b.z)
	end

	if (type(operand_b) == "number") then
		return (operand_a.x < operand_b) and (operand_a.y < operand_b) and (operand_a.z < operand_b)
	end

	return (operand_a.x < operand_b.x) and (operand_a.y < operand_b.y) and (operand_a.z < operand_b.z)
end

--- Returns true if the vector is less than or equal to another vector.
function vector_mt.__le(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return (operand_a <= operand_b.x) and (operand_a <= operand_b.y) and (operand_a <= operand_b.z)
	end

	if (type(operand_b) == "number") then
		return (operand_a.x <= operand_b) and (operand_a.y <= operand_b) and (operand_a.z <= operand_b)
	end

	return (operand_a.x <= operand_b.x) and (operand_a.y <= operand_b.y) and (operand_a.z <= operand_b.z)
end

--- Add a vector to another vector.
function vector_mt.__add(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return vector(
			operand_a + operand_b.x,
			operand_a + operand_b.y,
			operand_a + operand_b.z
		)
	end

	if (type(operand_b) == "number") then
		return vector(
			operand_a.x + operand_b,
			operand_a.y + operand_b,
			operand_a.z + operand_b
		)
	end

	return vector(
		operand_a.x + operand_b.x,
		operand_a.y + operand_b.y,
		operand_a.z + operand_b.z
	)
end

--- Subtract a vector from another vector.
function vector_mt.__sub(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return vector(
			operand_a - operand_b.x,
			operand_a - operand_b.y,
			operand_a - operand_b.z
		)
	end

	if (type(operand_b) == "number") then
		return vector(
			operand_a.x - operand_b,
			operand_a.y - operand_b,
			operand_a.z - operand_b
		)
	end

	return vector(
		operand_a.x - operand_b.x,
		operand_a.y - operand_b.y,
		operand_a.z - operand_b.z
	)
end

--- Multiply a vector with another vector.
function vector_mt.__mul(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return vector(
			operand_a * operand_b.x,
			operand_a * operand_b.y,
			operand_a * operand_b.z
		)
	end

	if (type(operand_b) == "number") then
		return vector(
			operand_a.x * operand_b,
			operand_a.y * operand_b,
			operand_a.z * operand_b
		)
	end

	return vector(
		operand_a.x * operand_b.x,
		operand_a.y * operand_b.y,
		operand_a.z * operand_b.z
	)
end

--- Divide a vector by another vector.
function vector_mt.__div(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return vector(
			operand_a / operand_b.x,
			operand_a / operand_b.y,
			operand_a / operand_b.z
		)
	end

	if (type(operand_b) == "number") then
		return vector(
			operand_a.x / operand_b,
			operand_a.y / operand_b,
			operand_a.z / operand_b
		)
	end

	return vector(
		operand_a.x / operand_b.x,
		operand_a.y / operand_b.y,
		operand_a.z / operand_b.z
	)
end

--- Raised a vector to the power of another vector.
function vector_mt.__pow(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return vector(
			math.pow(operand_a, operand_b.x),
			math.pow(operand_a, operand_b.y),
			math.pow(operand_a, operand_b.z)
		)
	end

	if (type(operand_b) == "number") then
		return vector(
			math.pow(operand_a.x, operand_b),
			math.pow(operand_a.y, operand_b),
			math.pow(operand_a.z, operand_b)
		)
	end

	return vector(
		math.pow(operand_a.x, operand_b.x),
		math.pow(operand_a.y, operand_b.y),
		math.pow(operand_a.z, operand_b.z)
	)
end

--- Performs a modulo operation on a vector with another vector.
function vector_mt.__mod(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return vector(
			operand_a % operand_b.x,
			operand_a % operand_b.y,
			operand_a % operand_b.z
		)
	end

	if (type(operand_b) == "number") then
		return vector(
			operand_a.x % operand_b,
			operand_a.y % operand_b,
			operand_a.z % operand_b
		)
	end

	return vector(
		operand_a.x % operand_b.x,
		operand_a.y % operand_b.y,
		operand_a.z % operand_b.z
	)
end

--- Perform a unary minus operation on the vector.
function vector_mt.__unm(operand_a)
	return vector(
		-operand_a.x,
		-operand_a.y,
		-operand_a.z
	)
end

--- Returns the vector's 2 dimensional length squared.
function vector_mt:length2_squared()
	return (self.x * self.x) + (self.y * self.y);
end

--- Return's the vector's 2 dimensional length.
function vector_mt:length2()
	return math.sqrt(self:length2_squared())
end

--- Returns the vector's 3 dimensional length squared.
function vector_mt:length_squared()
	return (self.x * self.x) + (self.y * self.y) + (self.z * self.z);
end

--- Return's the vector's 3 dimensional length.
function vector_mt:length()
	return math.sqrt(self:length_squared())
end

-- Returns the vector's dot product.
function vector_mt:dot_product(other_vector)
	return (self.x * other_vector.x) + (self.y * other_vector.y) + (self.z * other_vector.z)
end

-- Returns the vector's cross product.
function vector_mt:cross_product(other_vector)
	return vector_mt(
		(self.y * other_vector.z) - (self.z * other_vector.y),
		(self.z * other_vector.x) - (self.x * other_vector.z),
		(self.x * other_vector.y) - (self.y * other_vector.x)
	)
end

--- Returns the 2 dimensional distance between the vector and another vector.
function vector_mt:distance2(other_vector)
	return (other_vector - self):length2()
end

--- Returns the 3 dimensional distance between the vector and another vector.
function vector_mt:distance(other_vector)
	return (other_vector - self):length()
end

--- Returns the distance on the X axis between the vector and another vector.
function vector_mt:distanceX(other_vector)
	return math.abs(self.x - other_vector.x)
end

--- Returns the distance on the Y axis between the vector and another vector.
function vector_mt:distanceY(other_vector)
	return math.abs(self.y - other_vector.y)
end

--- Returns the distance on the Z axis between the vector and another vector.
function vector_mt:distanceZ(other_vector)
	return math.abs(self.z - other_vector.z)
end

--- Returns true if the vector is within the given distance to another vector.
function vector_mt:in_range(other_vector, distance)
	return self:distance(other_vector) <= distance
end

--- Clamps the vector's coordinates to whole numbers. Equivalent to "vector:round" with no precision.
function vector_mt:round_zero()
	self.x = math.floor(self.x + 0.5)
	self.y = math.floor(self.y + 0.5)
	self.z = math.floor(self.z + 0.5)
end

--- Round the vector's coordinates.
function vector_mt:round(precision)
	self.x = math.round(self.x, precision)
	self.y = math.round(self.y, precision)
	self.z = math.round(self.z, precision)
end

--- Clamps the vector's coordinates to the nearest base.
function vector_mt:round_base(base)
	self.x = base * math.round(self.x / base)
	self.y = base * math.round(self.y / base)
	self.z = base * math.round(self.z / base)
end

--- Clamps the vector's coordinates to whole numbers. Equivalent to "vector:round" with no precision.
function vector_mt:rounded_zero()
	return vector(
		math.floor(self.x + 0.5),
		math.floor(self.y + 0.5),
		math.floor(self.z + 0.5)
	)
end

--- Round the vector's coordinates.
function vector_mt:rounded(precision)
	return vector(
		math.round(self.x, precision),
		math.round(self.y, precision),
		math.round(self.z, precision)
	)
end

--- Clamps the vector's coordinates to the nearest base.
function vector_mt:rounded_base(base)
	return vector(
		base * math.round(self.x / base),
		base * math.round(self.y / base),
		base * math.round(self.z / base)
	)
end

--- Normalize the vector.
function vector_mt:normalize()
	local length = self:length()

	if (length ~= 0) then  -- Preventing possible divide-by-zero error
		self.x = self.x / length
		self.y = self.y / length
		self.z = self.z / length
	else
		self.x = 0
		self.y = 0
		self.z = 1
	end
end

--- Returns the normalized length of a vector.
function vector_mt:normalized_length()
	return self:length()
end

--- Returns a copy of the vector, normalized.
function vector_mt:normalized()
	local length = self:length()

	if (length ~= 0) then
		return vector(
			self.x / length,
			self.y / length,
			self.z / length
		)
	else
		return vector(0, 0, 1)
	end
end

--- Returns a new 2 dimensional vector of the original vector when mapped to the screen, or nil if the operation fails.
function vector_mt:to_screen()
	local x, y = renderer.world_to_screen(self.x, self.y, self.z)

	if (x == nil or y == nil) then
		return nil
	end

	return vector(x, y)
end

--- Returns the magnitude of the vector, use this to determine the speed of the vector if it's a velocity vector.
function vector_mt:magnitude()
	return math.sqrt(
		math.pow(self.x, 2) +
		math.pow(self.y, 2) +
		math.pow(self.z, 2)
	)
end

--- Returns the euler angle of the vector in regards to another vector.
function vector_mt:angle_to(other_vector)
	-- Calculate the delta of vectors.
	local delta_vector = vector(other_vector.x - self.x, other_vector.y - self.y, other_vector.z - self.z)

	if (delta_vector.x == 0 and delta_vector.y == 0) then
		return angle((delta_vector.z > 0 and 270 or 90), 0)
	else
		-- Calculate the yaw.
		local yaw = math.deg(math.atan2(delta_vector.y, delta_vector.x))

		-- Calculate the pitch.
		local hyp = math.sqrt(delta_vector.x * delta_vector.x + delta_vector.y * delta_vector.y)
		local pitch = math.deg(math.atan2(-delta_vector.z, hyp))

		return angle(pitch, yaw)
	end
end

--- Draws a traceline between two vectors and returns the result.
function vector_mt:trace_line_to(other_vector, skip_entindex)
	skip_entindex = skip_entindex or 0

	return client.trace_line(
		skip_entindex,
		self.x,
		self.y,
		self.z,
		other_vector.x,
		other_vector.y,
		other_vector.z
	)
end

--- Calculates a bullet trajectory from one player to a vector.
function vector_mt:trace_bullet_to(from_player, other_vector)
	return client.trace_bullet(
		from_player,
		self.x,
		self.y,
		self.z,
		other_vector.x,
		other_vector.y,
		other_vector.z
	)
end
--endregion

--region angle_vector_methods
--- Returns all unit vectors of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_unit_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))
	local sr = math.sin(degrees_to_radians(self.r))
	local cr = math.cos(degrees_to_radians(self.r))

	local forward = vector(cp * cy, cp * sy, -sp)
	local right = vector(sr * sp * cy * -1 + cr * sy, sr * sp * sy * -1 + -1 * cr * cy, -1 * sr * cp)
	local up = vector(cr * sp * cy + sr * sy, cr * sp * sy + sr * cy * -1, cr * cp)

	return {
		forward = forward,
		right = right,
		up = up,
		backward = -forward,
		left = -right,
		bottom = -up
	}
end

--- Returns a forward vector of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_forward_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))

	return vector(cp * cy, cp * sy, -sp)
end

--- Return an up vector of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_up_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))
	local sr = math.sin(degrees_to_radians(self.r))
	local cr = math.cos(degrees_to_radians(self.r))

	return vector(cr * sp * cy + sr * sy, cr * sp * sy + sr * cy * -1, cr * cp)
end

--- Return a right vector of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_right_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))
	local sr = math.sin(degrees_to_radians(self.r))
	local cr = math.cos(degrees_to_radians(self.r))

	return vector(sr * sp * cy * -1 + cr * sy, sr * sp * sy * -1 + -1 * cr * cy, -1 * sr * cp)
end

--- Return a backward vector of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_backward_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))

	return -vector(cp * cy, cp * sy, -sp)
end

--- Return a left vector of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_left_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))
	local sr = math.sin(degrees_to_radians(self.r))
	local cr = math.cos(degrees_to_radians(self.r))

	return -vector(sr * sp * cy * -1 + cr * sy, sr * sp * sy * -1 + -1 * cr * cy, -1 * sr * cp)
end

--- Return a down vector of the angle. Use this to convert an angle into a cartesian direction.
function angle_mt:to_down_vector()
	local degrees_to_radians = function(degrees) return degrees * math.pi / 180 end

	local sp = math.sin(degrees_to_radians(self.p))
	local cp = math.cos(degrees_to_radians(self.p))
	local sy = math.sin(degrees_to_radians(self.y))
	local cy = math.cos(degrees_to_radians(self.y))
	local sr = math.sin(degrees_to_radians(self.r))
	local cr = math.cos(degrees_to_radians(self.r))

	return -vector(cr * sp * cy + sr * sy, cr * sp * sy + sr * cy * -1, cr * cp)
end
--endregion
--endregion

local player_last_shot_time = {}

local priortize_targets_enabled = ui.new_checkbox("LUA", "B", "Priortize targets")
local priortize_targets_flags = ui.new_multiselect("LUA", "B", "Flags", "High Velocity", "In Air", "Under X hp", "Shot Fired")
local velocity_threshold = ui.new_slider("LUA", "B", "Velocity Threshold", 0, 250, 200)
local health_threshold = ui.new_slider("LUA", "B", "Health Threshold", 0, 100, 30)

local ref_ragebot_enabled = ui.reference("RAGE", "Aimbot", "Enabled")
local ref_player_list = ui.reference("PLAYERS", "Players", "Player list")
local ref_priortize = ui.reference("PLAYERS", "Adjustments", "High priority")

local function contains(table, item)
    for i = 0, #table do
        if table[i] == item then
            return true
        end
    end

    return false
end

local function handle_ui()
    local main_state = ui.get(priortize_targets_enabled)
    local flags = ui.get(priortize_targets_flags)

    ui.set_visible(priortize_targets_flags, main_state)
    ui.set_visible(velocity_threshold, main_state and contains(flags, "High Velocity"))
    ui.set_visible(health_threshold, main_state and contains(flags, "Under X hp"))
end

local function set_priortize_player(entity, status)
    ui.set(ref_player_list, entity)
    ui.set(ref_priortize, status)
end

local function on_net_update_end()
	if not (ui.get(ref_ragebot_enabled) or ui.get(priortize_targets_enabled)) then return end
    
    local local_player = entity.get_local_player()
	if local_player == nil or not entity.is_alive(local_player) then return end

    local player_list = entity.get_players(true)
    if player_list == nil then return end

    local priortize_flags = ui.get(priortize_targets_flags)

    for i = 0, #player_list do
        local player = player_list[i]

        if player ~= nil and entity.is_alive(player) then
			local velocity = vector(entity.get_prop(player, "m_vecVelocity", 3))
            local flags = entity.get_prop(player, "m_fFlags")
            local health = entity.get_prop(player, "m_iHealth")

            if contains(priortize_flags, "High Velocity") then
                set_priortize_player(player, velocity:length() > ui.get(velocity_threshold))
            end

            if contains(priortize_flags, "In Air") then
                set_priortize_player(player, not bit.band(flags, 0x0001))  -- ON_GROUND = 0x0001
			end

            if contains(priortize_flags, "Under X hp") then
                set_priortize_player(player, health <= ui.get(health_threshold))
            end

            if contains(priortize_flags, "Shot Fired") and player_last_shot_time[player] ~= nil then
                set_priortize_player(player, (globals.curtime() - player_last_shot_time[player]) <= 0.2)
            end
        end
    end
end

local function on_bullet_impact(event)
	if not (ui.get(ref_ragebot_enabled) or ui.get(priortize_targets_enabled)) then return end

    local local_player = entity.get_local_player()
    if local_player == nil or not entity.is_alive(local_player) then return end

    local event_entity = client.userid_to_entindex(event.userid)
    if event_entity == local_player then return end

    player_last_shot_time[event_entity] = globals.curtime()
end

handle_ui()
ui.set_callback(priortize_targets_enabled, handle_ui)
ui.set_callback(priortize_targets_flags, handle_ui)

client.set_event_callback("net_update_end", on_net_update_end)
client.set_event_callback("bullet_impact", on_bullet_impact)