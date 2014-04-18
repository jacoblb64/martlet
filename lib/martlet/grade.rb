module Martlet
	class Grade
		include Comparable

		attr_reader :letter

		def initialize(letter)
			@letter = letter.upcase
		end

		def <=>(other)
			letters.index(letter) <=> letters.index(other.letter)
		end

		private

		def letters
			%w{P S R CO A A- B+ B B- C+ C D F U HH J K KE K* KF IC KK L LE L* NA && NE NR W WF WL W-- -- IP Q}
		end
	end
end
