Particle[] particles;
final float rotationSpeed = 0.005;

void setup() {
	size(500, 500);

	particles = new Particle[500];

	for (int i = 0; i < particles.length; i++) {
		particles[i] = new Particle();
	}

	particles[0] = new OddballParticle();
}

void draw() {
	background(177,177,177);

	sort(particles);

	for (Particle particle : particles) {
		particle.draw();

		if (keyPressed) {
			switch(key) {
				case 'w':
				particle.rotateX(rotationSpeed);
				break;
				case 's': 
				particle.rotateX(-rotationSpeed);
				break;
				case 'a': 
				particle.rotateY(rotationSpeed);
				break;
				case 'd': 
				particle.rotateY(-rotationSpeed);
				break;
				case 'q': 
				particle.rotateZ(rotationSpeed);
				break;
				case 'e': 
				particle.rotateZ(-rotationSpeed);
				break;
			}
		}
	}
}

class Particle {
	protected float x, y, z, velocity, azumith, theta;
	protected int radius, col;

	public Particle(float x, float y, float z, float velocity, float azumith, float theta) {
		this.x = x;
		this.y = y;
		this.z = z;

		this.velocity = velocity;
		this.azumith = azumith;
		this.theta = theta;

		col = color(random(100), random(100), random(100));
		radius = 4;
	}

	public Particle(float x, float y, float z) {
		this(x, y, z, random(7, 10), random(TWO_PI), random(TWO_PI));
	}	

	public Particle() {
		this(0,0,0);
	}

	public void draw() {
		float vX, vY, vZ;
		vX = velocity * cos(azumith) * sin(theta);
		vY = velocity * sin(azumith) * sin(theta);
		vZ = velocity * cos(theta);
		
		x += vX;
		y += vY;
		z += vZ;
 
		velocity *= 0.95;
		
		fill(col);
		noStroke();
		ellipse(x + width / 2.0, y + height / 2.0, radius, radius);
	}

	public void rotateX(float theta) {
		y = y * cos(theta) - z * sin(theta);
		z = y * sin(theta) + z * cos(theta);
	}

	public void rotateY(float theta) {
		x = x * cos(theta) + z * sin(theta);
		z = - x * sin(theta) + z * cos(theta);
	}

	public void rotateZ(float theta) {
		x = x * cos(theta) - y * sin(theta);
		y = x * sin(theta) + y * cos(theta);
	}

	public float getX() {
		return x;
	}

	public int getRadius() {
		return radius;
	}

	public float getFront() {
		return getX() + getRadius();
	}
}

class OddballParticle extends Particle {
	public OddballParticle() {
		super();

		velocity = 0;

		col = color(0, 255, 0);
		radius = 20;
	}
}

void mousePressed() {
	for (int i = 0; i < particles.length; i++) {
		particles[i] = new Particle();
	}
	particles[250] = new OddballParticle();
}

void sort(Particle[] particles) {
	for (int i = 0; i < particles.length; i++) {
		for (int j = i + 1; i < particles.length; i++) {
			Particle temp;
			if (particles[i].getRadius() < particles[j].getRadius()) {
				temp = particles[i];
				particles[i] = particles[j];
				particles[j] = temp;
			}
		}
	}
}
