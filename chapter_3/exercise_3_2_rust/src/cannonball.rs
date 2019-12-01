use bbggez::color::random_bright_color;
use bbggez::ggez::{
	graphics,
	nalgebra::{Point2, Vector2},
	Context,
};
use bbggez::mesh::create_circle;
use bbggez::traits::NatureOfCode;

pub struct Cannonball {
	pub location: Vector2<f32>,
	pub velocity: Vector2<f32>,
	acceleration: Vector2<f32>,
	pub mesh: graphics::Mesh,
	pub fired: bool,
	pub mass: f32,
	pub rotation: f32,
	pub rotation_velocity: f32,
	rotation_acceleration: f32,
	min_rotation: f32,
	max_rotation: f32,
	pub bounced: bool,
}

impl Cannonball {
	pub fn apply_rotation_force(&mut self) {
		self.rotation_acceleration = self.velocity.x;
	}

	pub fn apply_rotation_drag(&mut self, drag: f32) {
		self.rotation_acceleration = drag;
	}
}

impl NatureOfCode for Cannonball {
	fn new(x: f32, y: f32, mass: f32, context: &mut Context) -> Cannonball {
		let location = Vector2::new(x, y);
		let velocity = Vector2::new(0.0, 0.0);
		let acceleration = Vector2::new(0.0, 0.0);
		let mesh = graphics::MeshBuilder::new()
			.circle(
				graphics::DrawMode::stroke(3.0),
				Point2::new(0.0, 0.0),
				mass / 10.0,
				10.0,
				random_bright_color(),
			)
			.build(context)
			.unwrap();
		let fired = false;
		let rotation = 0.0;
		let rotation_velocity = 0.0;
		let rotation_acceleration = 0.0;
		let min_rotation = -5.0;
		let max_rotation = 5.0;
		let bounced = false;

		Cannonball {
			location,
			velocity,
			acceleration,
			mesh,
			fired,
			mass,
			rotation,
			rotation_velocity,
			rotation_acceleration,
			min_rotation,
			max_rotation,
			bounced,
		}
	}

	fn update(&mut self, delta_time: f32) {
		self.velocity += self.acceleration;
		self.location += self.velocity * delta_time;
		self.acceleration *= 0.0;
		self.rotation_velocity += self.rotation_acceleration;
		if self.rotation_velocity > self.max_rotation {
			self.rotation_velocity = self.max_rotation;
		} else if self.rotation_velocity < self.min_rotation {
			self.rotation_velocity = self.min_rotation;
		}
		self.rotation += self.rotation_velocity * delta_time;
		self.rotation_acceleration = 0.0;
	}

	fn apply_force(&mut self, force: Vector2<f32>) {
		self.acceleration += force;
	}

	fn reverse_horizontal_velocity(&mut self) {
		self.velocity.x *= -1.0;
	}

	fn reverse_vertical_velocity(&mut self) {
		self.velocity.y *= -1.0 / (self.mass / 100.0);
	}
}
