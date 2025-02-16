local Randoms = {}

-- temp
function make_point(vec) 
	local newPart = Instance.new("Part");

	newPart.Shape = Enum.PartType.Ball;
	newPart.Size = Vector3.new(1,1,1);
	newPart.Position = vec;
	newPart.BrickColor = BrickColor.new("Bright green");
	newPart.Material = Enum.Material.Neon;
	newPart.Name = "Point";
	newPart.Anchored = true;
	newPart.Parent = workspace;
end

-- Module functions

function Randoms.randomInt(min: int, max: int)
	local rng = Random.new();
	return math.floor(rng:NextNumber() * (max - min) + min + 0.5);
end

function Randoms.randomVec3(vec1: Vector3, vec2: Vector3)
	local rng = Random.new();
	local min, max, x, y, z;
	
	if vec1.x < vec2.x then
		min = vec1.x; max = vec2.x;
	else
		min = vec2.x; max = vec1.x;
	end
	x = rng:NextNumber() * (max - min) + min;
	
	if vec1.y < vec2.y then
		min = vec1.y; max = vec2.y;
	else
		min = vec2.y; max = vec1.y;
	end
	y = rng:NextNumber() * (max - min) + min;
	
	if vec1.z < vec2.z then
		min = vec1.z; max = vec2.z;
	else
		min = vec2.z; max = vec1.z;
	end
	z = rng:NextNumber() * (max - min) + min;
	
	return Vector3.new(x, y, z);
end

function Randoms.randomRegion3(region1: Region3, region2: Region3, fixedx: boolean, fixedy: boolean, fixedz: boolean)
	local region1vec1 = region1.CFrame.Position - region1.Size / 2;
	local region1vec2 = region1.CFrame.Position + region1.Size / 2;
	local region2vec1 = region2.CFrame.Position - region2.Size / 2;
	local region2vec2 = region2.CFrame.Position + region2.Size / 2;
	local newVec1 = Randoms.randomVec3(region1vec1, region2vec1);
	local newVec2 = Randoms.randomVec3(region1vec2, region2vec2);
	if fixedx then
		newVec1 = Vector3.new(region1vec1.X, newVec1.Y, newVec1.Z);
		newVec2 = Vector3.new(region1vec2.X, newVec2.Y, newVec2.Z);
	end
	
	if fixedy then
		newVec1 = Vector3.new(newVec1.X, region1vec1.Y, newVec1.Z);
		newVec2 = Vector3.new(newVec2.X, region1vec2.Y, newVec2.Z);
	end
	
	if fixedz then
		newVec1 = Vector3.new(newVec1.X, newVec1.Y, region1vec1.Z);
		newVec2 = Vector3.new(newVec2.X, newVec2.Y, region1vec2.Z);
	end
	make_point(newVec1);
	make_point(newVec2);
	return Region3.new(newVec1, newVec2);
end

return Randoms