class SuperherosController < ApplicationController
    before_action :authorize!, only: [:new, :create, :edit, :update, :destroy]
    before_action :superhero_get!, only: [:show, :edit, :update, :destroy]

    def index
        if params[:name]
            create_superhero_from_api(params[:name])
        end
        @superheros = Superhero.all
    end

    def show
    end

    def new
        @superheros = superhero_starts_with(params[:search])
        @superhero = Superhero.new
    end

    def create
        p superhero = create_superhero_from_api(params[:name])
        if superhero.valid?
            superhero.save
            redirect_to superhero
        else
            flash[:message] = superhero.errors.full_messages
            redirect_to new_superhero_path
        end
    end

    def edit
    
    end

    def update
        superhero = @superhero.update(params.require(:superhero).permit(:name, :description, :imgurl))
        if superhero.valid?
            redirect_to supehero_path(@superhero)
        else
            flash[:message] = superhero.errors.full_messages
            redirect_to edit_supehero_path(@superhero)
        end
    end

    def destroy
        @superhero.destroy
        redirect_to superheros_path
    end
    private

    def superhero_params
        params.require(:superhero).permit(:name, :description, :imgurl, :search)
    end

    def superhero_get!
        @superhero = Superhero.find_by(id: params[:id])
    end
end