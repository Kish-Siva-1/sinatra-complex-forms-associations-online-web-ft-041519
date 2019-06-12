class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:pet][:owner_id]
      @pet.create_owner(params[:owner])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])
      @pet.owner = owner 
    else 
      @pet.update(owner_id: params[:pet][:owner_ids])
    end 
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end