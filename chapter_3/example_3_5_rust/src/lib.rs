use bbggez::ggez::{
	event::EventHandler,
	graphics,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::{rand, rand::prelude::*};
use std::f32::consts::PI;

const TWO_PI: f32 = PI * 2.0;

pub struct Game {
	amplitude: f32,
	frames: f32,
	location: Vector2<f32>,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		let (arena_width, arena_height) = graphics::drawable_size(context);

		Game {
			amplitude: 100.0,
			frames: 12000.0,
			location: Vector2::new(arena_width / 2.0, arena_height / 2.0),
		}
	}

	fn handle_window_size_change(
		&self,
		context: &mut Context,
		(width, height): (f32, f32),
	) -> GameResult<()> {
		graphics::set_screen_coordinates(context, graphics::Rect::new(0.0, 0.0, width, height))
	}
}

impl EventHandler for Game {
	fn update(&mut self, context: &mut Context) -> GameResult<()> {
		let delta_time = timer::delta(context).as_secs_f32();
		let arena_size = graphics::drawable_size(context);
		self.handle_window_size_change(context, arena_size)?;

		self.location.x = arena_size.0 / 2.0
			+ self.amplitude * (PI * PI * timer::ticks(context) as f32 / self.frames).cos();

		Ok(())
	}

	fn draw(&mut self, context: &mut Context) -> GameResult<()> {
		graphics::clear(context, graphics::BLACK);
		let (arena_width, arena_height) = graphics::drawable_size(context);

		let circle = graphics::MeshBuilder::new()
			.circle(
				graphics::DrawMode::fill(),
				Point2::new(0.0, 0.0),
				50.0,
				0.01,
				graphics::WHITE,
			)
			.build(context)?;

		graphics::draw(
			context,
			&circle,
			graphics::DrawParam::new().dest(Point2::from(self.location)),
		)?;

		graphics::present(context)
	}
}
