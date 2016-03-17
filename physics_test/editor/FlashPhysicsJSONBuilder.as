﻿/**
 * Created by Anton Nefjodov on 14.03.2016.
 */
package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class FlashPhysicsJSONBuilder extends Sprite
	{
		public function FlashPhysicsJSONBuilder()
		{
			var world:MovieClip = new world_1();
			world.gotoAndStop(2);

			var worldData:Object =
			{
				id:world.name,
				bodies:[

				],
				joints:[

				]
			};
			if(world.gravity)
			{
				worldData.gravity = world.gravity;
			}else
			{
				worldData.gravity = {x:0, y:100};
			}

			for each (var physObject:MovieClip in getAllChildren(world))
			{
				var body:MovieClip;
				var joint:MovieClip;
				if(physObject is MovieClip)
				{
					if(physObject is pivot_joint)
					{
						joint = physObject;

						var jointData:Object = {
							id:joint.name,
							type:"pivot",
							x:joint.x,
							y:joint.y,
							minAngle:joint.minAngle,
							maxAngle:joint.maxAngle
						};
						if(joint.bodies)
						{
							jointData.bodies = joint.bodies;
						}
						worldData.joints.push(jointData);
					}else
					{
						body = physObject;

						worldData.bodies.push(
								{
									x:body.x,
									y:body.y,
									angle:body.rotation * Math.PI / 180,
									id:body.name,
									type:body.type,
									shapes:getBodyShapes(body)
								}
						);
					}
				}
			}

			var jsonString:String = JSON.stringify(worldData);
			trace(jsonString);
		}

		private function getBodyShapes(body:Object):Array
		{
			var shapes:Array = [];

			for each (var shape:Object in getAllChildren(body as DisplayObjectContainer))
			{
				if(shape is DisplayObjectContainer)
				{
					var shapeData:Object = {
						x:shape.x,
						y:shape.y,
						angle:shape.rotation * Math.PI / 180,
						id:shape.name
					};
					if(!isCircleShape(shape))
					{
						shapeData.vertices = getShapeVertices(shape);
					}else
					{
						shapeData.radius = shape.width / 2;
					}
					if(shape.filter)
					{
						shapeData.filter = {};
						if(shape.filter.collisionGroup)
						{
							shapeData.filter.collisionGroup = shape.filter.collisionGroup;
						}
						if(shape.filter.collisionMask)
						{
							shapeData.filter.collisionMask = shape.filter.collisionMask;
						}
						if(shape.filter.sensorGroup)
						{
							shapeData.filter.sensorGroup = shape.filter.sensorGroup;
						}
						if(shape.filter.sensorMask)
						{
							shapeData.filter.sensorMask = shape.filter.sensorMask;
						}
						if(shape.filter.fluidGroup)
						{
							shapeData.filter.fluidGroup = shape.filter.fluidGroup;
						}
					}
					if(shape.material)
					{
						shapeData.material = {};
						if(shape.material.elasticity)
						{
							shapeData.material.elasticity = shape.material.elasticity;
						}
						if(shape.material.dynamicFriction)
						{
							shapeData.material.dynamicFriction = shape.material.dynamicFriction;
						}
						if(shape.material.staticFriction)
						{
							shapeData.material.staticFriction = shape.material.staticFriction;
						}
						if(shape.material.density)
						{
							shapeData.material.density = shape.material.density;
						}
						if(shape.material.rollingFriction)
						{
							shapeData.material.rollingFriction = shape.material.rollingFriction;
						}
					}
					shapes.push(shapeData);
				}
			}

			return shapes;
		}

		private function isCircleShape(shape:Object):Boolean
		{
			return shape is circle;
		}

		private function getShapeVertices(shape:Object):Array
		{
			var vertices:Vector.<Object> = new <Object>[];

			for each (var vertex:Object in getAllChildren(shape as DisplayObjectContainer))
			{
				if (vertex is DisplayObjectContainer)
				{
					var vertexData:Object = {
						id:vertex.name,
						x:vertex.x,
						y:vertex.y
					};

					vertices.push(vertexData);
				}
			}

			vertices.sort(sortVertices);

			return toArray(vertices);
		}

		private function sortVertices(v1:Object, v2:Object):Number
		{
			var index_1:int = parseInt(v1.id.split("_")[1]);
			var index_2:int = parseInt(v2.id.split("_")[1]);

			if(index_1 > index_2){
				return 1;
			}
			if(index_1 < index_2){
				return -1;
			}
			return 0;
		}

		private function toArray(iterable:*):Array {
			var ret:Array = [];
			for each (var elem:* in iterable) ret.push(elem);
			return ret;
		}

		private function getAllChildren(container:DisplayObjectContainer):Array {
			var allChildren:Array = [];
			var l:uint = container.numChildren;
			while (l--) {
				allChildren.push(container.getChildAt(l));
			}
			return allChildren;
		}
	}
}
