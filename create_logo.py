#!/usr/bin/env python3
"""
Generate sample icon.png and logo.png for Chisel Home Assistant Addon
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_icon(size=48):
    """Create icon.png"""
    # Create transparent image
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Calculate dimensions
    margin = size // 8
    tunnel_width = size - 2 * margin
    tunnel_height = tunnel_width // 2
    
    # Draw tunnel entrance (outer circle)
    outer_radius = tunnel_width // 2
    center = size // 2
    draw.ellipse([
        center - outer_radius, 
        center - tunnel_height // 2,
        center + outer_radius, 
        center + tunnel_height // 2
    ], outline=(0, 150, 136, 255), width=2)
    
    # Draw tunnel exit (inner circle)
    inner_radius = outer_radius // 2
    draw.ellipse([
        center - inner_radius,
        center - tunnel_height // 2,
        center + inner_radius,
        center + tunnel_height // 2
    ], fill=(0, 150, 136, 100), outline=(0, 150, 136, 255), width=1)
    
    # Draw connection lines
    line_length = outer_radius // 3
    # Left line
    draw.line([
        (margin, center),
        (margin + line_length, center)
    ], fill=(0, 150, 136, 255), width=2)
    # Right line
    draw.line([
        (size - margin - line_length, center),
        (size - margin, center)
    ], fill=(0, 150, 136, 255), width=2)
    
    return img

def create_logo(size=128):
    """Create logo.png"""
    # Create transparent image
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Calculate dimensions
    margin = size // 8
    tunnel_width = size - 2 * margin
    tunnel_height = tunnel_width // 2
    
    # Draw tunnel entrance (outer circle)
    outer_radius = tunnel_width // 2
    center = size // 2
    draw.ellipse([
        center - outer_radius, 
        center - tunnel_height // 2,
        center + outer_radius, 
        center + tunnel_height // 2
    ], outline=(0, 150, 136, 255), width=4)
    
    # Draw tunnel exit (inner circle)
    inner_radius = outer_radius // 2
    draw.ellipse([
        center - inner_radius,
        center - tunnel_height // 2,
        center + inner_radius,
        center + tunnel_height // 2
    ], fill=(0, 150, 136, 100), outline=(0, 150, 136, 255), width=2)
    
    # Draw connection lines with arrows
    line_length = outer_radius // 3
    arrow_size = 8
    
    # Left line with arrow
    draw.line([
        (margin, center),
        (margin + line_length, center)
    ], fill=(0, 150, 136, 255), width=4)
    # Left arrow
    draw.polygon([
        (margin + line_length, center - arrow_size),
        (margin + line_length + arrow_size, center),
        (margin + line_length, center + arrow_size)
    ], fill=(0, 150, 136, 255))
    
    # Right line with arrow
    draw.line([
        (size - margin - line_length, center),
        (size - margin, center)
    ], fill=(0, 150, 136, 255), width=4)
    # Right arrow
    draw.polygon([
        (size - margin - line_length, center - arrow_size),
        (size - margin - line_length - arrow_size, center),
        (size - margin - line_length, center + arrow_size)
    ], fill=(0, 150, 136, 255))
    
    # Add "CHISEL" text at the bottom
    try:
        # Try to use a system font
        font_size = size // 8
        font = ImageFont.truetype("/System/Library/Fonts/Arial.ttf", font_size)
    except:
        # Fallback to default font
        font = ImageFont.load_default()
    
    text = "CHISEL"
    text_bbox = draw.textbbox((0, 0), text, font=font)
    text_width = text_bbox[2] - text_bbox[0]
    text_height = text_bbox[3] - text_bbox[1]
    
    text_x = (size - text_width) // 2
    text_y = size - margin - text_height
    
    # Draw text with outline
    draw.text((text_x, text_y), text, fill=(0, 150, 136, 255), font=font)
    
    return img

def main():
    """Generate both icon and logo"""
    print("Creating Chisel addon icons...")
    
    # Create icon.png (48x48)
    icon = create_icon(48)
    icon.save("chisel/icon.png")
    print("✓ Created icon.png (48x48)")
    
    # Create logo.png (128x128)
    logo = create_logo(128)
    logo.save("chisel/logo.png")
    print("✓ Created logo.png (128x128)")
    
    print("\nIcons created successfully!")
    print("Files saved to:")
    print("- chisel/icon.png")
    print("- chisel/logo.png")

if __name__ == "__main__":
    main() 