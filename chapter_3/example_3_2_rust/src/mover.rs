use bbggez::{
	color,
	ggez::{graphics, nalgebra::Vector2, Context},
	mesh,
};

pub trait NatureOfCode {
	fn new(x: f32, y: f32, mass: f32, context: &mut Context) -> Self;

	fn update(&mut self, delta_time: f32);

	fn apply_force(&mut self, force: Vector2<f32>);

	fn reverse_horizontal_velocity(&mut self);

	fn reverse_vertical_velocity(&mut self);
}

pub struct Mover {
	pub location: Vector2<f32>,
	pub velocity: Vector2<f32>,
	acceleration: Vector2<f32>,
	pub mesh: graphics::Mesh,
	pub rotation: f32,
	angular_velocity: f32,
	angular_acceleration: f32,
	pub mass: f32,
}

impl NatureOfCode for Mover {
	fn new(x: f32, y: f32, size: f32, context: &mut Context) -> Mover {
		let location = Vector2::new(x, y);
		let mesh = mesh::create_square(
			0.0 - size / 2.0,
			0.0 - size / 2.0,
			size,
			color::random_dark_color(),
			context,
		);
		let rotation = 0.0;
		let angular_velocity = 0.0;
		let velocity = Vector2::new(0.0, 0.0);
		let acceleration = Vector2::new(0.0, 0.0);
		let angular_acceleration = 0.0;

		Mover {
			location,
			velocity,
			acceleration,
			mesh,
			rotation,
			angular_velocity,
			angular_acceleration,
			mass: size,
		}
	}

	fn update(&mut self, delta_time: f32) {
		self.angular_acceleration += self.velocity.x / 1000.0;
		self.angular_velocity += self.angular_acceleration;

		if self.angular_velocity > 5.0 {
			self.angular_velocity = 5.0;
		} else if self.angular_velocity < -5.0 {
			self.angular_velocity = -5.0;
		}
		self.rotation += self.angular_velocity * delta_time;
		self.velocity += self.acceleration;
		self.location += self.velocity * delta_time;
		self.acceleration *= 0.0;
		self.angular_acceleration = 0.0;
	}

	fn apply_force(&mut self, force: Vector2<f32>) {
		self.acceleration += force;
	}

	fn reverse_vertical_velocity(&mut self) {
		self.velocity.y *= -1.0;
	}

	fn reverse_horizontal_velocity(&mut self) {
		self.velocity.x *= -1.0;
	}
}
