use bbggez::ggez::{
	event::EventHandler,
	graphics,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::{rand, rand::prelude::*};

pub struct Game {
	theta: f32,
	length: f32,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		Game {
			theta: 0.0,
			length: 100.0,
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

		self.theta += 1.0 * delta_time;

		Ok(())
	}

	fn draw(&mut self, context: &mut Context) -> GameResult<()> {
		graphics::clear(context, graphics::BLACK);

		let (arena_width, arena_height) = graphics::drawable_size(context);

		let line = graphics::MeshBuilder::new()
			.line(
				&[Point2::new(0.0, 0.0), Point2::new(self.length, 0.0)],
				2.0,
				graphics::WHITE,
			)?
			.build(context)?;

		let circle = graphics::MeshBuilder::new()
			.circle(
				graphics::DrawMode::fill(),
				Point2::new(0.0, 0.0),
				25.0,
				0.1,
				graphics::WHITE,
			)
			.build(context)?;

		graphics::draw(
			context,
			&line,
			graphics::DrawParam::new()
				.dest(Point2::new(arena_width / 2.0, arena_height / 2.0))
				.rotation(self.theta),
		)?;

		graphics::draw(
			context,
			&circle,
			graphics::DrawParam::new()
				.dest(Point2::new(
					(self.length * self.theta.cos()) + arena_width / 2.0,
					self.length * self.theta.sin() + arena_height / 2.0,
				))
				.rotation(self.theta),
		)?;

		graphics::present(context)
	}
}
