require 'rails_helper'

RSpec.describe MovieResult do
  it 'exists' do
    attrs = {
      info: {
        vote_average: 8.5,
        id: 34,
        genres: [{ name: 'Thriller' }, { name: 'Horror' }],
        overview: 'This movie is thrilling',
        original_title: 'Misery',
        runtime: 169
      },
      cast: { cast: [{ name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' },
                     { name: 'Kathy Bates', character: 'Annie Wilkes' }] },
      reviews: { results: [{ author: 'Lady Man', content: 'I love this movie' },
                           { author: 'Lady Man', content: 'I love this movie' },
                           { author: 'Lady Man', content: 'I love this movie' },
                           { author: 'Lady Man', content: 'I love this movie' }] }
    }

    movie = MovieResult.new(attrs[:info], attrs[:cast], attrs[:reviews])
    expect(movie).to be_a MovieResult
    expect(movie).to have_attributes(title: 'Misery',
                                     average_vote: 8.5,
                                     genres: %w[Thriller Horror],
                                     id: 34,
                                     summary: 'This movie is thrilling',
                                     run_time: 169,
                                     cast: ['Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes',
                                            'Kathy Bates as Annie Wilkes'],
                                     reviews: [{ content: 'I love this movie',
                                                 author: 'Lady Man' },
                                               { content: 'I love this movie',
                                                 author: 'Lady Man' },
                                               { content: 'I love this movie',
                                                 author: 'Lady Man' },
                                               { content: 'I love this movie',
                                                 author: 'Lady Man' }])
  end
end
