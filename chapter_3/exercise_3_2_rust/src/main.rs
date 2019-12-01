use bbggez::ggez::{conf::Conf, event, ContextBuilder};
use exercise_3_2_rust::*;

fn main() {
    let mut conf = Conf::new();
    conf.window_mode = conf.window_mode.resizable(true).dimensions(2500.0, 1015.0);
    conf.window_setup = conf.window_setup.title("");
    let (mut context, mut event_loop) = ContextBuilder::new("", "Brookzerker")
        .conf(conf)
        .build()
        .expect("Game context was not able to be created");
    let mut game = Game::new(&mut context);

    match event::run(&mut context, &mut event_loop, &mut game) {
        Ok(_) => println!("Exited cleanly"),
        Err(error) => println!("Error occured: {}", error),
    };
}
