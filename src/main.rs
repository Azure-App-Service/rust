#[macro_use]
extern crate log;
extern crate env_logger;

extern crate rustful;

use std::error::Error;

use rustful::{Server, Context, Response};

fn main() {
  env_logger::init().unwrap();

  let server_result = Server {
    host: 8080.into(),
    ..Server::new(|_: Context, res: Response| res.send("Hello Rust on App Service!"))
  }.run();

  match server_result {
    Ok(_server) => {},
    Err(e) => error!("Could not start server: {}", e.description())
  }
}

