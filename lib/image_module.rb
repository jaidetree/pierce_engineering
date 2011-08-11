module Photos
	require 'mini_magick'

	def self.upload( image )
		images = {}
		filename = Time.now.to_f.to_s.gsub('.','_') + '_' + image.original_filename
		photo = "#{RAILS_ROOT}/public/photos/#{filename}"
		photo = photo.gsub /\..*$/, '' << ".jpg"
		image = MiniMagick::Image.open( image.tempfile )	
		image.format "jpg"
		image.write photo

		images[:big] = generate_thumbnail photo, 'big', 600
		images[:med] = generate_thumbnail photo, 'med', 400
		images[:small] = generate_thumbnail photo, 'small', 50

		return images
	end

	def self.generate_thumbnail( file, label, width, crop = false )
		photo_name = file.gsub /\..*$/, '' << '_' << label << ".jpg"
		image = MiniMagick::Image.open( file )	

		w, h = image['%w %h'].split

		w = w.to_f
		h = h.to_f
		if ! crop

			if w > width
				h = (h*(width/w)).to_i
				w = width
			end

		else

			if w < h
				remove = (( h - w)/2).round
				image.shave("0x#{remove}")
			elsif w > h
				remove = ((w - h)/2).round
				image.shave("#{remove}x0")
			end

			image.resize("#{width}x#{height}")

		end

		image.resize "#{w}x#{h}"

		image.write photo_name

		return photo_name
	end
end
