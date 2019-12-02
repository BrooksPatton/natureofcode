use bbggez::{
	color::random_dark_color,
	ggez::{
		graphics,
		nalgebra::{Point2, Vector2},
		Context,
	},
	traits::NatureOfCode,
};

pub struct Car {
	pub location: Vector2<f32>,
	pub mesh: graphics::Mesh,
	velocity: Vector2<f32>,
	acceleration: Vector2<f32>,
}

impl NatureOfCode for Car {
	fn new(x: f32, y: f32, mass: f32, context: &mut Context) -> Car {
		let color = random_dark_color();
		let mesh = graphics::MeshBuilder::new()
			.rectangle(
				graphics::DrawMode::fill(),
				graphics::Rect::new(0.0, 0.0, 50.0, 15.0),
				color,
			)
			.polyline(
				graphics::DrawMode::fill(),
				&[
					Point2::new(50.0, 0.0),
					Point2::new(65.0, 7.5),
					Point2::new(50.0, 15.0),
				],
				color,
			)
			.unwrap()
			.build(context)
			.unwrap();

		Car {
			location: Vector2::new(x, y),
			mesh,
			velocity: Vector2::new(0.0, 0.0),
			acceleration: Vector2::new(0.0, 0.0),
		}
	}

	fn update(&mut self, delta_time: f32) {
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
