use bbggez::ggez::{
	event::EventHandler,
	event::{KeyCode, KeyMods},
	graphics,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::{rand, rand::prelude::*};

pub struct Game {
	location: Vector2<f32>,
	rotation: f32,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		let (arena_width, arena_height) = graphics::drawable_size(context);

		Game {
			location: Vector2::new(arena_width / 2.0, arena_height / 2.0),
			rotation: 0.0,
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

		let ship = graphics::MeshBuilder::new()
			.polyline(
				graphics::DrawMode::fill(),
				&[
					Point2::new(-7.0, -5.0),
					Point2::new(10.0, 0.0),
					Point2::new(-7.0, 5.0),
				],
				graphics::WHITE,
			)?
			.build(context)?;

		graphics::draw(
			context,
			&ship,
			graphics::DrawParam::new()
				.dest(Point2::from(self.location))
				.rotation(self.rotation),
		)?;

		graphics::present(context)
	}

	fn key_down_event(
		&mut self,
		context: &mut Context,
		keycode: KeyCode,
		_keymods: KeyMods,
		_repeat: bool,
	) {
		let delta_time = timer::delta(context).as_secs_f32();

		match keycode {
			KeyCode::Left => self.rotation += -50.0 * delta_time,
			KeyCode::Right => self.rotation += 50.0 * delta_time,
			_ => (),
		}
	}
}
