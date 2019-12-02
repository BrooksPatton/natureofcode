mod mover;

use bbggez::ggez::{
	event::EventHandler,
	graphics,
	input::mouse,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::traits::NatureOfCode;
use bbggez::{rand, rand::prelude::*};
use mover::Mover;

pub struct Game {
	mover: Mover,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		let (arena_width, arena_height) = graphics::drawable_size(context);

		Game {
			mover: Mover::new(arena_width / 2.0, arena_height / 2.0, 50.0, context),
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

		let mouse_location = mouse::position(context);
		let mouse_location = Vector2::new(mouse_location.x, mouse_location.y);
		let force = (mouse_location - self.mover.location).normalize() * 5.0;

		let drag = (self.mover.velocity * -1.0) * 0.001;

		self.mover.apply_force(force);
		self.mover.apply_force(drag);
		self.mover.update(delta_time);

		Ok(())
	}

	fn draw(&mut self, context: &mut Context) -> GameResult<()> {
		graphics::clear(context, graphics::BLACK);

		graphics::draw(
			context,
			&self.mover.mesh,
			graphics::DrawParam::new()
				.dest(Point2::from(self.mover.location))
				.rotation(self.mover.rotation),
		)?;

		graphics::present(context)
	}
}
