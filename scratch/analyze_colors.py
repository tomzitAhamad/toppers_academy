import os
from PIL import Image

def analyze_edges():
    image_path = "/Users/macbookair/.gemini/antigravity-ide/brain/2c1fde12-0299-4efc-9b15-1cd51dc1a0fe/media__1782103787875.png"
    if not os.path.exists(image_path):
        print(f"Image not found at {image_path}")
        return
    
    img = Image.open(image_path)
    img = img.convert('RGB')
    width, height = img.size
    
    print("Sampling along left edge (x=10):")
    for fraction in [0.05, 0.2, 0.4, 0.6, 0.8, 0.95]:
        y = int((height - 1) * fraction)
        rgb = img.getpixel((10, y))
        hex_val = '#{:02x}{:02x}{:02x}'.format(*rgb)
        print(f"y={y} ({fraction:.2%}): Hex={hex_val}")
        
    print("\nSampling along right edge (x=width-10):")
    for fraction in [0.05, 0.2, 0.4, 0.6, 0.8, 0.95]:
        y = int((height - 1) * fraction)
        rgb = img.getpixel((width - 10, y))
        hex_val = '#{:02x}{:02x}{:02x}'.format(*rgb)
        print(f"y={y} ({fraction:.2%}): Hex={hex_val}")

if __name__ == '__main__':
    analyze_edges()
