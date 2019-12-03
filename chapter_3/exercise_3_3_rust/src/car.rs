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
	pub rotation: f32,
}

impl NatureOfCode for Car {
	fn new(x: f32, y: f32, mass: f32, context: &mut Context) -> Car {
		let color = random_dark_color();
		let width = 50.0;
		let height = 15.0;
		let hood = 15.0;
		let mesh = graphics::MeshBuilder::new()
			.rectangle(
				graphics::DrawMode::fill(),
				graphics::Rect::new(-width / 2.0, -height / 2.0, width / 2.0, height / 2.0),
				color,
			)
			.polyline(
				graphics::DrawMode::fill(),
				&[
					Point2::new(width / 2.0, -height / 2.0),
					Point2::new(width / 2.0 + hood, 0.0),
					Point2::new(width / 2.0, height / 2.0),
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
			rotation: 0.0,
		}
	}

	fn update(&mut self, delta_time: f32) {
		self.velocity += self.acceleration;
		self.location += self.velocity * delta_time;
		self.acceleration *= 0.0;
		self.rotation = self.velocity.y.atan2(self.velocity.x);
	}

	fn apply_force(&mut self, force: Vector2<f32>) {
		self.acceleration += force;
	}

	fn reverse_horizontal_velocity(&mut self) {}

	fn reverse_vertical_velocity(&mut self) {}
}
