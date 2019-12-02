use bbggez::color::random_bright_color;
use bbggez::ggez::{graphics, nalgebra::Vector2, Context};
use bbggez::mesh::create_rect;
use bbggez::traits::NatureOfCode;

pub struct Mover {
	pub location: Vector2<f32>,
	pub mesh: graphics::Mesh,
	pub rotation: f32,
	pub velocity: Vector2<f32>,
	acceleration: Vector2<f32>,
}

impl NatureOfCode for Mover {
	fn new(x: f32, y: f32, _mass: f32, context: &mut Context) -> Mover {
		let width = 50.0;
		let height = 15.0;
		let mesh = create_rect(
			0.0 - width / 2.0,
			0.0 - height / 2.0,
			width,
			height,
			random_bright_color(),
			context,
		);

		Mover {
			location: Vector2::new(x, y),
			mesh,
			velocity: Vector2::new(0.0, 0.0),
			rotation: 0.0,
			acceleration: Vector2::new(0.0, 0.0),
		}
	}

	fn update(&mut self, delta_time: f32) {
		self.rotation = self.velocity.y.atan2(self.velocity.x);
		self.velocity += self.acceleration;
		self.location += self.velocity * delta_time;
		self.acceleration *= 0.0;
	}

	fn apply_force(&mut self, force: Vector2<f32>) {
		self.acceleration += force;
	}

	fn reverse_horizontal_velocity(&mut self) {}

	fn reverse_vertical_velocity(&mut self) {}
}
