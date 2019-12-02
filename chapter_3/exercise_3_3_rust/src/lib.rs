mod car;

use bbggez::ggez::{
	event::EventHandler,
	graphics,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::traits::NatureOfCode;
use bbggez::{rand, rand::prelude::*};
use car::Car;

pub struct Game {
	car: Car,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		let arena_size = graphics::drawable_size(context);

		Game {
			car: Car::new(arena_size.0 / 2.0, arena_size.1 / 2.0, 50.0, context),
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

		Ok(())
	}

	fn draw(&mut self, context: &mut Context) -> GameResult<()> {
		graphics::clear(context, graphics::BLACK);

		graphics::draw(
			context,
			&self.car.mesh,
			graphics::DrawParam::new().dest(Point2::from(self.car.location)),
		)?;

		graphics::present(context)
	}
}
