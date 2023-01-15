#!/usr/bin/env python3
import platform
import os
import stressypy
from flask import Flask

app = Flask(__name__)

@app.route("/")
def main():
  return "<html> \
          <head> \
              <style> \
              body { background-color: %s; } \
              </style> \
          </head> \
          <body> \
              <div align='center'><h1>Hello from %s !</h1><h2>%s</h2></div> \
          </body> \
          </html>" % ("orange", platform.node(), platform.platform())

@app.route("/stress")
@app.route("/stress/<stress_seconds>")
def stress(stress_seconds=10):
    stress_job = stressypy.create_job(os.cpu_count(), int(stress_seconds))
    stress_job.run()
    return "Stress test for %s CPUs in %s seconds" % (os.cpu_count(), stress_seconds)

if __name__ == "__main__":
    app.run(host='0.0.0.0')
