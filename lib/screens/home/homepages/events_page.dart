import "package:flutter/material.dart";
import "package:hikersafrique/items/favourites.dart";
import "package:hikersafrique/screens/home/home_screen.dart";
import "package:hikersafrique/services/database.dart";
import "package:provider/provider.dart";
import "../../../items/best_places.dart";
import "../../../items/hotels.dart";
import "../../../items/most_visited.dart";
import "../../../items/new_added.dart";
import "../../../items/restaurants.dart";
import "../../../models/event.dart";
import "../../../services/auth_notifier.dart";

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => Future(() => setState(() {})),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: FutureBuilder<List<Event>>(
                          future: Database.getSavedEvents(
                              Provider.of<AuthNotifier>(context)
                                  .user!
                                  .clientEmail),
                          initialData: const [],
                          builder: (context, snapshot) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(right: 20),
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                return SavedEvent(
                                  event: snapshot.data![index],
                                );
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              // Category of best places,most visited etc
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      // BestPlaces Container
                      BestPlacesContainer(),
                      // Most Visited Container
                      MostVisitedContainer(),
                      //Favourites Container
                      FavouriteContainer(),
                      // New Added Container
                      NewAddedContainer(),
                      // Hotels Container
                      HotelsContainer(),
                      // Restaurants Container
                      RestaurantContainer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              FutureBuilder<List<Event>>(
                  future: Database.getAvailableEvents(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        return EventItem(
                          event: snapshot.data![index],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
