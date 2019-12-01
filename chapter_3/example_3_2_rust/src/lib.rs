mod mover;

use bbggez::ggez::{
	event::EventHandler,
	graphics,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::{rand, rand::prelude::*};
use mover::{Mover, NatureOfCode};

pub struct Game {
	movers: Vec<Mover>,
	gravity: Vector2<f32>,
	wind: Vector2<f32>,
	drag: f32,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		let mut movers = vec![];
		let mut rng = rand::thread_rng();

		for _ in 0..10 {
			movers.push(Mover::new(50.0, 50.0, rng.gen_range(10.0, 100.0), context));
		}
		let gravity = Vector2::new(0.0, 0.5);
		let wind = Vector2::new(10.0, 0.0);
		let drag = 0.0001;

		Game {
			movers,
			gravity,
			wind,
			drag,
		}
	}
}

impl EventHandler for Game {
	fn update(&mut self, context: &mut Context) -> GameResult<()> {
		let delta_time = timer::delta(context).as_secs_f32();

		for mover in &mut self.movers {
			let mut drag = mover.velocity * -1.0;
			drag *= self.drag;
			mover.apply_force(self.gravity);
			let wind = self.wind / mover.mass;
			mover.apply_force(wind);
			mover.apply_force(drag);
			mover.update(delta_time);
			let (arena_width, arena_height) = graphics::drawable_size(context);
			if mover.location.y > arena_height {
				mover.location.y = arena_height;
				mover.reverse_vertical_velocity();
			}
			if mover.location.x > arena_width {
				mover.location.x = arena_width;
				mover.reverse_horizontal_velocity();
			}
		}

		Ok(())
	}

	fn draw(&mut self, context: &mut Context) -> GameResult<()> {
		graphics::clear(context, graphics::WHITE);

		for mover in &mut self.movers {
			graphics::draw(
				context,
				&mover.mesh,
				graphics::DrawParam::new()
					.dest(Point2::from(mover.location))
					.rotation(mover.rotation),
			)?;
		}

		graphics::present(context)
	}
}
