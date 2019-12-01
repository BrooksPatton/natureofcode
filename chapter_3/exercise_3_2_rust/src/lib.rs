mod cannonball;

use bbggez::ggez::{
	event::EventHandler,
	graphics,
	nalgebra::{Point2, Vector2},
	timer, Context, GameResult,
};
use bbggez::traits::NatureOfCode;
use bbggez::{rand, rand::prelude::*};
use cannonball::Cannonball;

pub struct Game {
	cannonball: Cannonball,
	gravity_force: Vector2<f32>,
	drag_force: f32,
}

impl Game {
	pub fn new(context: &mut Context) -> Game {
		let (_arena_width, arena_height) = graphics::drawable_size(context);
		let mass = 500.0;
		let mut cannonball = Cannonball::new(10.0, arena_height - 10.0, mass, context);
		cannonball.velocity = Vector2::new(500000.0, -500000.0) / mass;

		let gravity_force = Vector2::new(0.0, 1.0);
		let drag_force = 0.001;

		Game {
			cannonball,
			gravity_force,
			drag_force,
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

		self.cannonball.apply_force(self.gravity_force);
		if self.cannonball.location.y > arena_size.1 {
			self.cannonball.location.y = arena_size.1;
			self.cannonball.reverse_vertical_velocity();
			let drag = (self.cannonball.velocity * -1.0) * self.drag_force;
			self.cannonball.apply_force(drag);
			if self.cannonball.bounced {
				let drag = (self.cannonball.rotation_velocity * -1.0) * self.drag_force;
				self.cannonball.apply_rotation_drag(drag);
			} else {
				self.cannonball.apply_rotation_force();
				self.cannonball.bounced = true;
			}
		}
		self.cannonball.update(delta_time);

		Ok(())
	}

	fn draw(&mut self, context: &mut Context) -> GameResult<()> {
		graphics::clear(context, graphics::BLACK);

		graphics::draw(
			context,
			&self.cannonball.mesh,
			graphics::DrawParam::new()
				.dest(Point2::from(self.cannonball.location))
				.rotation(self.cannonball.rotation),
		)?;

		graphics::present(context)
	}
}
